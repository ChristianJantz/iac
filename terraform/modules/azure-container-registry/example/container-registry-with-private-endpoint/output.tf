# Container Registry
output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = module.acr.container_registry_id
}

# Container Registry - Private DNS
output "container_registry_private_dns_zone_id" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone ID"
  value       = module.acr.container_registry_private_dns_zone_id
}

output "container_registry_private_dns_zone_name" {
  description = "DNS zone name of Azure Container Registry Private DNS Zone Name"
  value       = module.acr.container_registry_private_dns_zone_name
}

# Container Registry - Private Link
output "container_registry_private_dns_zone_vnet_link_id" {
  description = "The ID of the Private DNS zone Virtual Network Link"
  value       = module.acr.container_registry_private_dns_zone_vnet_link_id
}

output "container_registry_private_dns_zone_vnet_link_name" {
  description = "The Name of the Private DNS zone Virtual Network Link"
  value       = module.acr.container_registry_private_dns_zone_vnet_link_name
}

# Container Registry - Private Endpoint
output "container_registry_private_endpoint_id" {
  description = "The ID of the Azure Container Registry Private Endpoint"
  value       = module.acr.container_registry_private_endpoint_id
}

output "container_registry_private_endpoint_name" {
  description = "The Name of the Azure Container Registry Private Endpoint"
  value       = module.acr.container_registry_private_endpoint_name
}
