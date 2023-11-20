
output "azurerm_postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.default.name
}

output "postgresql_flexible_server_database_name" {
  value = azurerm_postgresql_flexible_server_database.default.name
}

output "postgresql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.default.administrator_password
}

output "postgres_dns_vnet_link_name" {
  value = azurerm_private_dns_zone_virtual_network_link.postgres_dns_vnet_link.name
}
output "postgres_dns_name" {
  value = azurerm_private_dns_zone.postgresdns.name
}