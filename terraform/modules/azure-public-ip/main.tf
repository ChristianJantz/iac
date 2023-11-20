resource "azurerm_public_ip" "pip_aks" {
    name = var.public_ip_name
    location = var.resource_location
    resource_group_name = var.rg_name
    sku = "Standard"
    sku_tier = "Regional"
    allocation_method = "Static"
    tags = var.tags
}