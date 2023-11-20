output "vnet_name" {
  description = "The name of the virtual network"
  value       = try(module.vnet.vnet_name, null)
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = try(module.vnet.vnet_id, null)
}

output "vnet_address_space" {
  description = "List of address spaces that are used the virtual network."
  value       = try(module.vnet.vnet_address_space, null)
}

output "subnet_ids" {
  description = "List of IDs of subnets"
  value       = try(module.vnet.subnet_ids, null)
}

output "subnet_address_prefixes" {
  description = "List of address prefix for subnets"
  value       = try(module.vnet.subnet_address_prefixes, null)
}
