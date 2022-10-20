output "name" {
  value       = azurerm_postgresql_flexible_server.this.name
  description = "The name of the PostgreSQL Flexible Server"
}

output "id" {
  value       = azurerm_postgresql_flexible_server.this.id
  description = "The ID of the PostgreSQL Flexible Server"
}

output "fqdn" {
  value       = azurerm_postgresql_flexible_server.this.fqdn
  description = "The FQDN of the PostgreSQL Flexible Server"
}

output "public_network_access_enabled" {
  value       = azurerm_postgresql_flexible_server.this.public_network_access_enabled
  description = "Is public network access enabled?"
}

output "administrator_login" {
  value       = azurerm_postgresql_flexible_server.this.administrator_login
  description = "The administrator login name for the PostgreSQL Flexible Server"
}

output "administrator_password" {
  value       = azurerm_postgresql_flexible_server.this.administrator_password
  description = "The administrator password for the PostgreSQL Flexible Server"
  sensitive   = true
}
