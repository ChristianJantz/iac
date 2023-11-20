# Azure Log Analytics Workspace
Terraform Module to create a Log Analytic Workspace and a ContainerInsights Solution Plan.



<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_log_analytics_solution_id"></a> [azurerm\_log\_analytics\_solution\_id](#output\_azurerm\_log\_analytics\_solution\_id) | The ID of the Solution Plan which is created |
| <a name="output_azurerm_log_analytics_workspace_id"></a> [azurerm\_log\_analytics\_workspace\_id](#output\_azurerm\_log\_analytics\_workspace\_id) | The full ID of the Azure Log Analytics Workspace |
## Inputs

| Name | Description | Default |
|------|-------------|---------|
| <a name="input_location"></a> [location](#input\_location) | Location of the Workspace. Default is set to 'germanywestcentral' | `"germanywestcentral"` |
| <a name="input_log_analytics_solution"></a> [log\_analytics\_solution](#input\_log\_analytics\_solution) | (Optional) Object which contains existing azurerm\_log\_analytics\_solution ID. Providing ID disables creation of azurerm\_log\_analytics\_solution. | `null` |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | (Optional) Existing azurerm\_log\_analytics\_workspace to attach azurerm\_log\_analytics\_solution. Providing the config disables creation of azurerm\_log\_analytics\_workspace. | `null` |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018 | `"PerGB2018"` |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The retention period for the logs in days | `30` |
| <a name="input_name"></a> [name](#input\_name) | Name of the Workspace | n/a |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to be imported | n/a |
| <a name="input_solution_plan_map"></a> [solution\_plan\_map](#input\_solution\_plan\_map) | (Required) Specifies the solutions to deploy to log analytics workspace | <pre>{<br>  "ContainerInsights": {<br>    "product": "OMSGallery/ContainerInsights",<br>    "publisher": "Mircosoft"<br>  }<br>}</pre> |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix name for the worspace | `"workspace"` |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the AKS cluster resources | `{}` |
## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_solution.solution_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

<!-- END_TF_DOCS -->