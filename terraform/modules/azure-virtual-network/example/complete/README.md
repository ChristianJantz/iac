# Azure Virtual Network Terraform module

Terraform module which creates the Azure Virtual Network resource and its associated subnets.

## Usage
```
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

      # NSG configuration
      # Please follow the pattern below:
      # [name, priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix]

      nsg_inbound_rules  = [
        ["DenyInboundHTTP", "100", "Inbound", "Deny", "Tcp", "*", "80", "*", "*"],
        ["AllowInboundHTTPS", "105", "Inbound", "Allow", "Tcp", "*", "443", "*", "*"]
      ]
      
      nsg_outbound_rules = [
        ["AllowOutboundInternet", "100", "Outbound", "Allow", "*", "*", "*", "*", "Internet"]
      ]
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
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | List of address prefix for subnets |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | List of IDs of subnets |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | List of address spaces that are used the virtual network. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the virtual network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the virtual network |
