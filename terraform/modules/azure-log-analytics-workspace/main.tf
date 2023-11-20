
resource "azurerm_log_analytics_workspace" "workspace" {
  name = lower("${try(trim(var.name, "-workspace"), var.name)}-${var.suffix}")
  resource_group_name = var.resource_group_name
  location = var.location
  sku = var.log_analytics_workspace_sku
  retention_in_days = var.log_retention_in_days
  tags = var.tags
}


resource "azurerm_log_analytics_solution" "solution_plan" {
  tags = var.tags
  for_each = var.solution_plan_map

    solution_name = each.key
    resource_group_name = coalesce(try(var.log_analytics_workspace.resource_group_name, null), try(azurerm_log_analytics_workspace.workspace.resource_group_name, null), var.resource_group_name)
    location = coalesce(try(var.log_analytics_workspace.resource_group_name, null), try(azurerm_log_analytics_workspace.workspace.location, null), var.location)
    workspace_name = coalesce(try(var.log_analytics_workspace.name, null),azurerm_log_analytics_workspace.workspace.name)
    workspace_resource_id = coalesce(try(var.log_analytics_workspace.id, null),azurerm_log_analytics_workspace.workspace.id)

    plan {
      product = each.value.product
      publisher = each.value.publisher
    }
  

}