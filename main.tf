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
    for database in var.databases : "${database.name}" => database
    if database.name != null
  }
  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = each.value.collation
  charset   = each.value.charset
}
