output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.akv.id
}

output "key_vault_name" {
  description = "Name of the created key vault."
  value       = azurerm_key_vault.akv.name
}

output "key_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.akv.vault_uri
}

# Container Registry - Private DNS
output "key_vault_private_dns_zone_id" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone ID"
  value       = azurerm_private_dns_zone.akv_dns.id
}

output "key_vault_private_dns_zone_name" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone Name"
  value       = azurerm_private_dns_zone.akv_dns.name
}

# Container Registry - Private Link
output "key_vault_private_dns_zone_vnet_link_id" {
  description = "The ID of the Private DNS zone Virtual Network Link"
  value       = azurerm_private_dns_zone_virtual_network_link.akv_dns_vnet_link.id
}

output "key_vault_private_dns_zone_vnet_link_name" {
  description = "The Name of the Private DNS zone Virtual Network Link"
  value       = azurerm_private_dns_zone_virtual_network_link.akv_dns_vnet_link.name
}

# Container Registry - Private Endpoint
output "key_vault_private_endpoint_id" {
  description = "The ID of the Azure Container Registry Private Endpoint"
  value       = azurerm_private_endpoint.akv_private_endpoint.id
}

output "key_vault_private_endpoint_name" {
  description = "The Name of the Azure Container Registry Private Endpoint"
  value       = azurerm_private_endpoint.akv_private_endpoint.name
}
