# Container Registry
output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

# Container Registry - Private DNS
output "container_registry_private_dns_zone_id" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone ID"
  value       = try(azurerm_private_dns_zone.acr_dns.*.id)
}

output "container_registry_private_dns_zone_name" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone Name"
  value       = try(azurerm_private_dns_zone.acr_dns.*.name)
}

# Container Registry - Private Link
output "container_registry_private_dns_zone_vnet_link_id" {
  description = "The ID of the Private DNS zone Virtual Network Link"
  value       = try(azurerm_private_dns_zone_virtual_network_link.acr_dns_vnet_link.*.id)
}

output "container_registry_private_dns_zone_vnet_link_name" {
  description = "The Name of the Private DNS zone Virtual Network Link"
  value       = try(azurerm_private_dns_zone_virtual_network_link.acr_dns_vnet_link.*.name)
}

# Container Registry - Private Endpoint
output "container_registry_private_endpoint_id" {
  description = "The ID of the Azure Container Registry Private Endpoint"
  value       = try(azurerm_private_endpoint.acr_private_endpoint.*.id)
}

output "container_registry_private_endpoint_name" {
  description = "The Name of the Azure Container Registry Private Endpoint"
  value       = try(azurerm_private_endpoint.acr_private_endpoint.*.name)
}
