
# Azure Network Security Group Terraform Module
Terraform module which creates the NSG and alocated the rules to the subnet


<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |


## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_location"></a> [location](#input\_location) | Location of the network security group. Default is set to 'germanywestcentral' | `"germanywestcentral"` |
| <a name="input_name"></a> [name](#input\_name) | Name of the network security group | n/a |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | list of network security group rules . | n/a |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to be imported | n/a |
| <a name="input_snet_id"></a> [snet\_id](#input\_snet\_id) | The subnet ID to allocate the network security group | n/a |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | suffix name for the network security group | `"_nsg"` |
## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.nsg_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

<!-- END_TF_DOCS -->