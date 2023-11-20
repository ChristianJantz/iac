output "cosmosdb_account_endpoint" {
  description = "Endpoint of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_mongo_database_names" {
  description = "The names of the CosmosDB Mongo databases."
  value       = { for k, db in azurerm_cosmosdb_mongo_database.this : k => db.name }
}

output "private_endpoint_fqdn" {
  description = "The fully qualified domain name for the private endpoint."
  value       = azurerm_private_endpoint.this.custom_dns_configs[0].fqdn
}

output "private_dns_zone_name" {
  description = "The private DNS zone name for the private endpoint."
  value       = azurerm_private_dns_zone.this.name
}
