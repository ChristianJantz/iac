provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_client_config" "current" {}

data "azuread_user" "akv" {
  for_each            = toset(["alexandre.cravid@pacemaker.ai", "christian.jantz@pacemaker.ai"])
  user_principal_name = each.value
}

data "azurerm_resource_group" "rg" {
  name = "test_group"
}

data "azurerm_virtual_network" "vnet" {
  name                = "test_group-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

module "akv" {
  source = "../../"

  # By default, this module will not create a resource group. 
  # Provide a name to use an existing resource group.
  # Location must be same as the existing resource group.
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = "West Europe"
  akv_name                      = "this-is-my-akv"
  key_vault_sku_tier            = "standard"
  soft_delete_retention_days    = 7
  public_network_access_enabled = true

  # Subnet config for the Key Vault
  akv_vnet_id   = data.azurerm_virtual_network.vnet.id
  akv_subnet_id = data.azurerm_subnet.subnet.id

  # Access Policies for those who are using the Key Vault
  access_policies = [
    {
      object_id           = data.azuread_user.akv["alexandre.cravid@pacemaker.ai"].object_id # d2c0eb5d-ee6b-4a5c-843f-45a83dc83701
      key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      secret_permissions  = ["Set", "List", "Get", "Delete", "Purge", "Recover"]
      storage_permissions = ["Get", "List"]
    },
    {
      object_id           = data.azuread_user.akv["christian.jantz@pacemaker.ai"].object_id # 25d5d3c6-26e2-45c3-ae3f-81e518ffe952
      key_permissions     = ["Get", "List"]
      secret_permissions  = ["Set", "Get", "Delete", "Purge", "Recover"]
      storage_permissions = ["Get", "List"]
    },
  ]

  # Create Secrets as needed.
  # To avoid security issues, leave the secret value field empty.
  # This module will generate a strong random secret with a value of 32 caracthers of length. 
  # Then change it in the Azure Portal.
  # secrets = {
  #   "myplaintextedsecret" = "p4c3m@k3r"
  #   "mysensitivesecret"   = ""
  # }
}
