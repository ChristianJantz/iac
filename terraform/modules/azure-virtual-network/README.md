<!-- BEGIN_TF_DOCS -->
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
  source = "../"

  # By default, this module will not create a resource group. 
  # Provide a name to use an existing resource group
  # Location must be same as the existing resource group.
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "germanywestcentral"
  vnet_name           = "this-is-my-TEST-vnet"
  vnet_address_space  = ["192.168.0.0/24"]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0, < 1.6.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.40.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0, < 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|---------|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created | n/a | Yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created | n/a | Yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Each subnet will create an object that contain fields | `{}` | No |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space that is used the virtual network. You can supply more than one address space | n/a | Yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network. Changing this forces a new resource to be created | n/a | Yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | List of address prefix for subnets |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | List of IDs of subnets |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | List of address spaces that are used the virtual network. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the virtual network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the virtual network |


## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

<!-- END_TF_DOCS -->