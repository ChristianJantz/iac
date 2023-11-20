output "vnet_name" {
  description = "The name of the virtual network"
  value       = try(azurerm_virtual_network.vnet.name, null)
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = try(azurerm_virtual_network.vnet.id, null)
}

output "vnet_address_space" {
  description = "List of address spaces that are used the virtual network."
  value       = try(flatten(concat(azurerm_virtual_network.vnet.address_space)), null)
}

output "subnet_ids" {
  description = "List of IDs of subnets"
  value       = try(flatten(concat([for subnets in azurerm_subnet.subnet : subnets.id])), null)
}

output "subnet_names" {
  description = "List of subnet names"
  value       = try(flatten(concat([for subnets in azurerm_subnet.subnet : subnets.name])), null)
}

output "subnet_address_prefixes" {
  description = "List of address prefix for subnets"
  value       = try(flatten(concat([for subnets in azurerm_subnet.subnet : subnets.address_prefixes])), null)
}
