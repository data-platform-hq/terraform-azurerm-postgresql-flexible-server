locals {
  ip_rules = { for e in [for k, ip in var.ip_rules : try(regex("/", ip), 0) != 0 ? { (k) = { start_ip_address = cidrhost(ip, 0), end_ip_address = cidrhost(ip, -1) } } : { (k) = { start_ip_address = ip, end_ip_address = ip } }] : keys(e)[0] => e[keys(e)[0]] }
}

resource "random_password" "password" {
  length           = 30
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "login" {
  length  = 16
  special = false
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "psql-${var.project}-${var.env}-${var.location}-${var.suffix}"
  resource_group_name    = var.resource_group
  location               = var.location
  version                = var.psql_version
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = var.zone_id
  administrator_login    = var.administrator_login == null ? random_string.login.result : var.administrator_login
  administrator_password = var.administrator_password == null ? random_password.password.result : var.administrator_password
  zone                   = var.zone
  storage_mb             = var.storage_mb
  sku_name               = var.sku_name
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  for_each = {
    for database in var.databases : database.name => database
    if database.name != null
  }
  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = each.value.collation
  charset   = each.value.charset
}


resource "azurerm_postgresql_flexible_server_firewall_rule" "this" {
  for_each         = local.ip_rules
  name             = "pgsql-firewall-rule-${var.project}-${var.env}-${var.location}-${each.key}"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = each.value["start_ip_address"]
  end_ip_address   = each.value["end_ip_address"]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "azure_services" {
  count            = var.allow_azure_services ? 1 : 0
  name             = "pgsql-firewall-rule-${var.project}-${var.env}-${var.location}-azure-services"
  server_id        = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.enable_diagnostic_setting ? 1 : 0
  resource_id = azurerm_postgresql_flexible_server.this.id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.enable_diagnostic_setting ? 1 : 0
  name                           = "psql-${var.project}-${var.env}-${var.location}-${var.suffix}"
  target_resource_id             = azurerm_postgresql_flexible_server.this.id
  log_analytics_workspace_id     = var.analytics_workspace_id
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].metrics
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type] # TODO remove when issue is fixed: https://github.com/Azure/azure-rest-api-specs/issues/9281
  }
}
