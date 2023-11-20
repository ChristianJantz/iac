<!-- BEGIN_TF_DOCS -->
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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Key Vault. |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Name of the created key vault. |
| <a name="output_key_vault_private_dns_zone_id"></a> [key\_vault\_private\_dns\_zone\_id](#output\_key\_vault\_private\_dns\_zone\_id) | DNS zone name of Azure Container Registry Private DNS Zone ID |
| <a name="output_key_vault_private_dns_zone_name"></a> [key\_vault\_private\_dns\_zone\_name](#output\_key\_vault\_private\_dns\_zone\_name) | DNS zone name of Azure Container Registry Private DNS Zone Name |
| <a name="output_key_vault_private_dns_zone_vnet_link_id"></a> [key\_vault\_private\_dns\_zone\_vnet\_link\_id](#output\_key\_vault\_private\_dns\_zone\_vnet\_link\_id) | The ID of the Private DNS zone Virtual Network Link |
| <a name="output_key_vault_private_dns_zone_vnet_link_name"></a> [key\_vault\_private\_dns\_zone\_vnet\_link\_name](#output\_key\_vault\_private\_dns\_zone\_vnet\_link\_name) | The Name of the Private DNS zone Virtual Network Link |
| <a name="output_key_vault_private_endpoint_id"></a> [key\_vault\_private\_endpoint\_id](#output\_key\_vault\_private\_endpoint\_id) | The ID of the Azure Container Registry Private Endpoint |
| <a name="output_key_vault_private_endpoint_name"></a> [key\_vault\_private\_endpoint\_name](#output\_key\_vault\_private\_endpoint\_name) | The Name of the Azure Container Registry Private Endpoint |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | List of access policies for the Key Vault. | `[]` |
| <a name="input_akv_name"></a> [akv\_name](#input\_akv\_name) | Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name. | n/a |
| <a name="input_akv_subnet_id"></a> [akv\_subnet\_id](#input\_akv\_subnet\_id) | The ID of the Subnet | n/a |
| <a name="input_akv_vnet_id"></a> [akv\_vnet\_id](#input\_akv\_vnet\_id) | The ID of the Virtual Network | n/a |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `false` |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `false` |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `false` |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `false` |
| <a name="input_key_vault_sku_tier"></a> [key\_vault\_sku\_tier](#input\_key\_vault\_sku\_tier) | The Tier of the SKU used for this Key Vault. Possible values are standard and premium. | `"standard"` |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | n/a |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this Key Vault | `false` |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault? | `false` |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | n/a |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of secrets for the Key Vault. | `{}` |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days. | `7` |
## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.akv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_zone.akv_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.akv_dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.akv_private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

<!-- END_TF_DOCS -->