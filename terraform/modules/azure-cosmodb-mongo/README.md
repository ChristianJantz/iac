# Azure Cosmos DB Mongo Terraform Module
## Overview
This Terraform module allows you to provision an Azure Cosmos DB Mongo in a resource group within an Azure region.

## Usage
To use this module, include it in your Terraform configuration as follows:

```
module "cosmosdb_mongo" {
  source = "https://github.com/westphalia-datalab/terraform-infrastructure/tree/main/terraform/modules/azure-cosmodb-mongo"

  # Required variables
  cosmosdb_account_name     = "my-cosmosdb-account"
  resource_group_name       = "my-resource-group"
  cosmosdb_account_location = "Germany West Central"
  geo_locations             = [{ location = "West Europe", failover_priority = 0 }]
  cosmosdb_mongo_databases = {
    _my_mongo_database = {
      name = "my-mongo-databse"
    }
  }
  subnet_name          = "snet-name"
  virtual_network_name = "vnet-name"

  # ... other configuration options ...

}
```

For detailed information on input variables and their descriptions, refer to the `variables.tf` file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cosmosdb_account_endpoint"></a> [cosmosdb\_account\_endpoint](#output\_cosmosdb\_account\_endpoint) | Endpoint of the Cosmos DB account |
| <a name="output_cosmosdb_mongo_database_names"></a> [cosmosdb\_mongo\_database\_names](#output\_cosmosdb\_mongo\_database\_names) | The names of the CosmosDB Mongo databases. |
| <a name="output_private_dns_zone_name"></a> [private\_dns\_zone\_name](#output\_private\_dns\_zone\_name) | The private DNS zone name for the private endpoint. |
| <a name="output_private_endpoint_fqdn"></a> [private\_endpoint\_fqdn](#output\_private\_endpoint\_fqdn) | The fully qualified domain name for the private endpoint. |
## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_access_key_metadata_writes_enabled"></a> [access\_key\_metadata\_writes\_enabled](#input\_access\_key\_metadata\_writes\_enabled) | Whether access key metadata writes are enabled for the Cosmos DB Account. | `true` |
| <a name="input_analytical_storage_enabled"></a> [analytical\_storage\_enabled](#input\_analytical\_storage\_enabled) | Whether analytical storage is enabled for the Cosmos DB Account. | `false` |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | The capabilities which should be enabled for this Cosmos DB account. | `[]` |
| <a name="input_consistency_level"></a> [consistency\_level](#input\_consistency\_level) | The consistency level of the Cosmos DB Account. | `"Session"` |
| <a name="input_cosmosdb_account_backup"></a> [cosmosdb\_account\_backup](#input\_cosmosdb\_account\_backup) | A backup for the Cosmos DB Account. | `[]` |
| <a name="input_cosmosdb_account_cors_rule"></a> [cosmosdb\_account\_cors\_rule](#input\_cosmosdb\_account\_cors\_rule) | CORS rule for the Cosmos DB Account. | `[]` |
| <a name="input_cosmosdb_account_identity"></a> [cosmosdb\_account\_identity](#input\_cosmosdb\_account\_identity) | Identity for the Cosmos DB Account. | `[]` |
| <a name="input_cosmosdb_account_location"></a> [cosmosdb\_account\_location](#input\_cosmosdb\_account\_location) | Specifies the supported Azure location where the resource exists. | n/a |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | The name of the Cosmos DB Account. | n/a |
| <a name="input_cosmosdb_account_restore"></a> [cosmosdb\_account\_restore](#input\_cosmosdb\_account\_restore) | Restore for the Cosmos DB Account. | `[]` |
| <a name="input_cosmosdb_account_tags"></a> [cosmosdb\_account\_tags](#input\_cosmosdb\_account\_tags) | The tags specifically for the Cosmos DB Account. | `{}` |
| <a name="input_cosmosdb_account_timeouts"></a> [cosmosdb\_account\_timeouts](#input\_cosmosdb\_account\_timeouts) | Timeouts for the Cosmos DB Account. | <pre>{<br>  "create": "180m",<br>  "delete": "180m",<br>  "read": "5m",<br>  "update": "180m"<br>}</pre> |
| <a name="input_cosmosdb_mongo_database_timeouts"></a> [cosmosdb\_mongo\_database\_timeouts](#input\_cosmosdb\_mongo\_database\_timeouts) | Timeouts for the CosmosDB Mongo Database. | <pre>{<br>  "create": "30m",<br>  "delete": "30m",<br>  "read": "5m",<br>  "update": "30m"<br>}</pre> |
| <a name="input_cosmosdb_mongo_databases"></a> [cosmosdb\_mongo\_databases](#input\_cosmosdb\_mongo\_databases) | A map defining the properties of the CosmosDB Mongo Database(s). | n/a |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The create mode of the Cosmos DB Account. | `"Default"` |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | The name of the network interface associated with the private endpoint. | `null` |
| <a name="input_default_identity_type"></a> [default\_identity\_type](#input\_default\_identity\_type) | The default identity type of the Cosmos DB Account. | `"FirstPartyIdentity"` |
| <a name="input_enable_automatic_failover"></a> [enable\_automatic\_failover](#input\_enable\_automatic\_failover) | Whether automatic failover is enabled for the Cosmos DB Account. | `true` |
| <a name="input_enable_free_tier"></a> [enable\_free\_tier](#input\_enable\_free\_tier) | Whether the free tier is enabled for the Cosmos DB Account. | `false` |
| <a name="input_enable_multiple_write_locations"></a> [enable\_multiple\_write\_locations](#input\_enable\_multiple\_write\_locations) | Whether multiple write locations are enabled for the Cosmos DB Account. | `null` |
| <a name="input_general_tags"></a> [general\_tags](#input\_general\_tags) | General tags to be merged with the tags of each resource. | `{}` |
| <a name="input_geo_locations"></a> [geo\_locations](#input\_geo\_locations) | Specifies the supported Azure locations for the geo-replication. | `[]` |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | A collection of IP configuration for the private endpoint. | `[]` |
| <a name="input_ip_range_filter"></a> [ip\_range\_filter](#input\_ip\_range\_filter) | The IP range filter for the Cosmos DB Account. | `""` |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | A flag indicating if the private endpoint connection is manual. | `false` |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Whether the virtual network filter is enabled for the Cosmos DB Account. | `null` |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | The ID of the Key Vault key for the Cosmos DB Account. | `null` |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of the Cosmos DB Account. | `"MongoDB"` |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Whether local authentication is disabled for the Cosmos DB Account. | `false` |
| <a name="input_max_interval_in_seconds"></a> [max\_interval\_in\_seconds](#input\_max\_interval\_in\_seconds) | The maximum interval in seconds. | `5` |
| <a name="input_max_staleness_prefix"></a> [max\_staleness\_prefix](#input\_max\_staleness\_prefix) | The maximum staleness prefix. | `100` |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | The MongoDB server version for the Cosmos DB Account. | `null` |
| <a name="input_network_acl_bypass_for_azure_services"></a> [network\_acl\_bypass\_for\_azure\_services](#input\_network\_acl\_bypass\_for\_azure\_services) | Whether network ACL bypass for Azure services is enabled for the Cosmos DB Account. | `false` |
| <a name="input_network_acl_bypass_ids"></a> [network\_acl\_bypass\_ids](#input\_network\_acl\_bypass\_ids) | The network ACL bypass IDs for the Cosmos DB Account. | `[]` |
| <a name="input_offer_type"></a> [offer\_type](#input\_offer\_type) | The offer type to provide Cosmos DB Account. | `"Standard"` |
| <a name="input_private_dns_zone_tags"></a> [private\_dns\_zone\_tags](#input\_private\_dns\_zone\_tags) | A map of tags to assign to the private DNS zone. | `{}` |
| <a name="input_private_dns_zone_timeouts"></a> [private\_dns\_zone\_timeouts](#input\_private\_dns\_zone\_timeouts) | Timeout settings for the private DNS zone. | <pre>{<br>  "create": "30m",<br>  "delete": "30m",<br>  "read": "5m",<br>  "update": "30m"<br>}</pre> |
| <a name="input_private_dns_zone_virtual_network_link_tags"></a> [private\_dns\_zone\_virtual\_network\_link\_tags](#input\_private\_dns\_zone\_virtual\_network\_link\_tags) | A map of tags to assign to the virtual network link. | `{}` |
| <a name="input_private_dns_zone_virtual_network_link_timeouts"></a> [private\_dns\_zone\_virtual\_network\_link\_timeouts](#input\_private\_dns\_zone\_virtual\_network\_link\_timeouts) | Timeout settings for the private DNS zone virtual network link. | <pre>{<br>  "create": "30m",<br>  "delete": "30m",<br>  "read": "5m",<br>  "update": "30m"<br>}</pre> |
| <a name="input_private_endpoint_tags"></a> [private\_endpoint\_tags](#input\_private\_endpoint\_tags) | A map of tags to assign to the private endpoint. | `{}` |
| <a name="input_private_endpoint_timeouts"></a> [private\_endpoint\_timeouts](#input\_private\_endpoint\_timeouts) | Timeout settings for the private endpoint. | <pre>{<br>  "create": "60m",<br>  "delete": "60m",<br>  "read": "5m",<br>  "update": "60m"<br>}</pre> |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled for the Cosmos DB Account. | `false` |
| <a name="input_registration_enabled"></a> [registration\_enabled](#input\_registration\_enabled) | A flag indicating if auto-registration of virtual machine records in the DNS zone is enabled. | `true` |
| <a name="input_request_message"></a> [request\_message](#input\_request\_message) | The request message for the private endpoint connection. | `null` |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Cosmos DB Account. | n/a |
| <a name="input_schema_type"></a> [schema\_type](#input\_schema\_type) | The schema type of the analytical storage of Cosmos DB Account. | `"WellDefined"` |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | A collection of Start of Authority (SOA) record properties. | `[]` |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet where the Private Endpoint will be linked. | n/a |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | The list of subresource names which the Private Endpoint is able to connect to. | <pre>[<br>  "MongoDB"<br>]</pre> |
| <a name="input_total_throughput_limit"></a> [total\_throughput\_limit](#input\_total\_throughput\_limit) | The total throughput limit of the Cosmos DB Account. | `-1` |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the Virtual Network for DNS resolution. | n/a |
| <a name="input_virtual_network_rules"></a> [virtual\_network\_rules](#input\_virtual\_network\_rules) | Specifies virtual\_network\_rules resources, used to define which subnets are allowed to access this CosmosDB account. | `[]` |
## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_mongo_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_mongo_database) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

<!-- END_TF_DOCS -->
