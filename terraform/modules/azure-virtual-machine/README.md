# Azure virtual machine vm 

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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_admin_password"></a> [vm\_admin\_password](#output\_vm\_admin\_password) | n/a |
| <a name="output_vm_admin_username"></a> [vm\_admin\_username](#output\_vm\_admin\_username) | n/a |
## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin Passwort für die Linux VM | n/a |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin Benutzername für die Linux VM | n/a |
| <a name="input_data_sa_type"></a> [data\_sa\_type](#input\_data\_sa\_type) | Data Disk Storage Account type. Default is set to 'Standard\_LRS'. | `"Standard_LRS"` |
| <a name="input_location"></a> [location](#input\_location) | Location of the VM Ressources. Default is set to 'germanywestcentral' | `"germanywestcentral"` |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `"workbench"` |
| <a name="input_storage_image_offer"></a> [storage\_image\_offer](#input\_storage\_image\_offer) | Offer of the storage image | `"0001-com-ubuntu-server-jammy"` |
| <a name="input_storage_image_publisher"></a> [storage\_image\_publisher](#input\_storage\_image\_publisher) | Publisher of the storage image | `"Canonical"` |
| <a name="input_storage_image_sku"></a> [storage\_image\_sku](#input\_storage\_image\_sku) | SKU of the storage | `"22_04-lts-gen2"` |
| <a name="input_storage_image_version"></a> [storage\_image\_version](#input\_storage\_image\_version) | Image version of the storage | n/a |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet | n/a |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the vm | n/a |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of vm | n/a |
| <a name="input_vm_resource_group_name"></a> [vm\_resource\_group\_name](#input\_vm\_resource\_group\_name) | Name of vm resource group | n/a |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the vm | `"standard_D2s_v3"` |
## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |

<!-- END_TF_DOCS -->