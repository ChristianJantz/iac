provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

module "acr" {
  source = "../../"

  # By default, this module will not create a resource group. 
  # Provide a name to use an existing resource group.
  # Location must be same as the existing resource group.
  acr_name            = "this-is-my-azure-acr"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  vnet_id             = data.azurerm_virtual_network.vnet.id
  subnet_id           = data.azurerm_subnet.subnet.id

  # ACR Geo-Replication is OPTIONAL!
  # The georeplications is only supported on resources with the Premium SKU.
  # The georeplications list cannot contain the location where the Container Registry exists.
  acr_georeplications = [
    {
      location                = "Germany West Central"
      zone_redundancy_enabled = true
    },
  ]
}
