output "pip_id_out" {
  value = azurerm_public_ip.pip_aks.id
}
output "pip_ip_out" {
    value = azurerm_public_ip.pip_aks.ip_address
}
output "pip_rg_out" {
  value = azurerm_public_ip.pip_aks.resource_group_name
}