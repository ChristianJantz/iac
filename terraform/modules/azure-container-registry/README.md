# Azure Container Registry Terraform module

Terraform module which creates Azure Container Registry resources.

### Private Link to Azure Container Registry

Azure Private Endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. Private Endpoint uses a private IP address from the VNet, effectively bringing the service into the VNet.

With Private Link, Microsoft Azure is offering the ability to associate a logical server to a specific private IP address (known as private endpoint) within the VNet. Users can connect to the Private endpoint from the same VNet, peered VNet in same region, or via VNet-to-VNet connection across regions. Additionally, users can connect from on-premises using ExpressRoute, private peering, or VPN tunneling.

By default, this feature **is NOT enabled** on this module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0, < 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0, < 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.4 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_acr_georeplications"></a> [acr\_georeplications](#input\_acr\_georeplications) | A list of Azure locations where the container registry should be geo-replicated | `[]` |
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | The name of the Azure Container Registry | n/a |
| <a name="input_acr_sku_tier"></a> [acr\_sku\_tier](#input\_acr\_sku\_tier) | The SKU name of the container registry. Possible values are Basic, Standard and Premium | `"Standard"` |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled. | `"false"` |
| <a name="input_location"></a> [location](#input\_location) | Region of the Azure Resources | n/a |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | The private DNS zone ID for the Private Endpoint | `[]` |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the container registry | `false` |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group | n/a |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet | n/a |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `{}` |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | The ID of the Virtual Network | n/a |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the Container Registry |
| <a name="output_container_registry_private_dns_zone_id"></a> [container\_registry\_private\_dns\_zone\_id](#output\_container\_registry\_private\_dns\_zone\_id) | DNS zone name of Azure Container Registry Private DNS Zone ID |
| <a name="output_container_registry_private_dns_zone_name"></a> [container\_registry\_private\_dns\_zone\_name](#output\_container\_registry\_private\_dns\_zone\_name) | DNS zone name of Azure Container Registry Private DNS Zone Name |
| <a name="output_container_registry_private_dns_zone_vnet_link_id"></a> [container\_registry\_private\_dns\_zone\_vnet\_link\_id](#output\_container\_registry\_private\_dns\_zone\_vnet\_link\_id) | The ID of the Private DNS zone Virtual Network Link |
| <a name="output_container_registry_private_dns_zone_vnet_link_name"></a> [container\_registry\_private\_dns\_zone\_vnet\_link\_name](#output\_container\_registry\_private\_dns\_zone\_vnet\_link\_name) | The Name of the Private DNS zone Virtual Network Link |
| <a name="output_container_registry_private_endpoint_id"></a> [container\_registry\_private\_endpoint\_id](#output\_container\_registry\_private\_endpoint\_id) | The ID of the Azure Container Registry Private Endpoint |
| <a name="output_container_registry_private_endpoint_name"></a> [container\_registry\_private\_endpoint\_name](#output\_container\_registry\_private\_endpoint\_name) | The Name of the Azure Container Registry Private Endpoint |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_private_dns_zone.acr_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.acr_dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.acr_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

<!-- END_TF_DOCS -->