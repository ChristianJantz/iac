
output "azurerm_log_analytics_workspace_id" {
  description = "The full ID of the Azure Log Analytics Workspace"
  value = azurerm_log_analytics_workspace.workspace.id
}
output "azurerm_log_analytics_solution_id" {
  description = "The ID of the Solution Plan which is created"
  value = {
    for k,sp in azurerm_log_analytics_solution.solution_plan: k => sp.id
  }
  
}