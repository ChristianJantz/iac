# output "vm_public_ip" {
#   value = try(azurerm_public_ip.linux_vm.ip_address, null)
# }

output "vm_admin_username" {
  value = var.admin_username
}

output "vm_admin_password" {
  value = var.admin_password
}
