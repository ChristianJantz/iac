output "rg_id" {
  description = "List of IDs of the Resource Groups"
  value       = try(flatten(concat([for rgs in azurerm_resource_group.rg : rgs.id])), null)
}

output "rg_name" {
  description = "List of Names of the Resource Groups"
  value       = try(flatten(concat([for rgs in azurerm_resource_group.rg : rgs.name])), null)
}

output "rg_location" {
  description = "List of Locations of the Resource Groups"
  value       = try(flatten(concat([for rgs in azurerm_resource_group.rg : rgs.location])), null)
}
