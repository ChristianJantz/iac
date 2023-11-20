# Azure Container Registry

locals {
  public_network_access_enabled = var.public_network_access_enabled == true ? 0 : 1
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.acr_sku_tier
  public_network_access_enabled = var.public_network_access_enabled
  admin_enabled                 = var.admin_enabled

  dynamic "georeplications" {
    for_each = var.acr_georeplications

    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
    }
  }
}

# DNS Name for Container Registry
resource "azurerm_private_dns_zone" "acr_dns" {
  count               = local.public_network_access_enabled
  name                = "${lower("${azurerm_container_registry.acr.name}")}.privatelink.azurecr.io"
  resource_group_name = azurerm_container_registry.acr.resource_group_name
}

# Private DNS Name Link to attach to the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "acr_dns_vnet_link" {
  count                 = local.public_network_access_enabled
  depends_on            = [azurerm_container_registry.acr, azurerm_private_dns_zone.acr_dns[0]]
  name                  = "${azurerm_container_registry.acr.name}-dns-vnet-link"
  resource_group_name   = azurerm_private_dns_zone.acr_dns[0].resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns[0].name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

# Private Endpoint
resource "azurerm_private_endpoint" "acr_private_endpoint" {
  count               = local.public_network_access_enabled
  name                = "pe-${azurerm_container_registry.acr.name}"
  location            = azurerm_container_registry.acr.location
  resource_group_name = azurerm_container_registry.acr.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${azurerm_container_registry.acr.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-${var.acr_name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_dns[0].id]
  }
}
