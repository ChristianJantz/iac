provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azurerm_resource_group" "rg" {
  name = "test_group"
}

module "vnet" {
  source = "../../"

  # By default, this module will not create a resource group. 
  # Provide a name to use an existing resource group
  # Location must be same as the existing resource group.
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "germanywestcentral"
  vnet_name           = "this-is-my-TEST-vnet"
  vnet_address_space  = ["192.168.0.0/24"]

  subnets = {
    aks_subnet = {
      subnet_name           = "snet-test-aks"
      subnet_address_prefix = ["192.168.0.0/28"]

      delegation = {
        name = "aksdelegation"
        service_delegation = {
          name = "Microsoft.ContainerInstance/containerGroups"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
        }
      }
    }

    database_subnet = {
      subnet_name           = "snet-test-database"
      subnet_address_prefix = ["192.168.0.16/28"]
      service_endpoints     = ["Microsoft.AzureCosmosDB"]

      delegation = {
        name = "dbdelegation"
        service_delegation = {
          name = "Microsoft.AzureCosmosDB/clusters"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      }
    }
  }
}
