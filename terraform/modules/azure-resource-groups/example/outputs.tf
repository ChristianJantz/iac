output "rg_id" {
  description = "List of IDs of the Resource Groups"
  value       = try(module.rg.rg_id, null)
}

output "rg_name" {
  description = "List of Names of the Resource Groups"
  value       = try(module.rg.rg_name, null)
}

output "rg_location" {
  description = "List of Locations of the Resource Groups"
  value       = try(module.rg.rg_location, null)
}
