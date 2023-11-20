# Azure Database for flexsible Postgres Server Cluster
Terraform module to create a flesible postgres Server

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
| <a name="output_azurerm_postgresql_flexible_server"></a> [azurerm\_postgresql\_flexible\_server](#output\_azurerm\_postgresql\_flexible\_server) | n/a |
| <a name="output_postgres_dns_vnet_link_endpoint_id"></a> [postgres\_dns\_vnet\_link\_endpoint\_id](#output\_postgres\_dns\_vnet\_link\_endpoint\_id) | n/a |
| <a name="output_postgres_dns_vnet_link_endpoint_name"></a> [postgres\_dns\_vnet\_link\_endpoint\_name](#output\_postgres\_dns\_vnet\_link\_endpoint\_name) | n/a |
| <a name="output_postgresql_flexible_server_admin_password"></a> [postgresql\_flexible\_server\_admin\_password](#output\_postgresql\_flexible\_server\_admin\_password) | n/a |
| <a name="output_postgresql_flexible_server_database_name"></a> [postgresql\_flexible\_server\_database\_name](#output\_postgresql\_flexible\_server\_database\_name) | n/a |
## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | Administrator login name for the flexsible postgres server | `"adminTerraform"` |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The Password for the Admin Login | `"postgres-flex14!"` |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | specifies  the backup rentention. the default is 7 days | `7` |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the delegated Subnet | n/a |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Enable Geo redundant Backup Default is set to 'false' | `false` |
| <a name="input_location"></a> [location](#input\_location) | Location for the flexsible Postgres Server | n/a |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | Postgres verion .Default is set to '14' | `"14"` |
| <a name="input_psql_subnet_id"></a> [psql\_subnet\_id](#input\_psql\_subnet\_id) | The ID of the delegated Subnet for the postgres server | n/a |
| <a name="input_psql_vnet_id"></a> [psql\_vnet\_id](#input\_psql\_vnet\_id) | The ID of the virtual network | n/a |
| <a name="input_psql_zone"></a> [psql\_zone](#input\_psql\_zone) | Specifies the avablitity zone for the postgres server | `"1"` |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | n/a |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | Name for the flexsinle Postgres Database Server | n/a |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the VM Size for the flexsible Postgres Server. Default is set to 'GP\_Standard\_D2s\_v3' | `"GP_Standard_D2s_v3"` |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | the Storage Gib for the Postgres Server Default is '32768' | `32768` |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the psql cluster resources | `{}` |
## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_database.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_zone.postgresdns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.postgres_dns_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.postgres_dns_vnet_link_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

<!-- END_TF_DOCS -->