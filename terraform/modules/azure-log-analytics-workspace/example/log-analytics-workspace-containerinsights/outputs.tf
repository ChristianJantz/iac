output "workspace_id" {
  value = module.workspace.azurerm_log_analytics_workspace_id
}
output "solution_plan_id" {
  value = module.workspace.azurerm_log_analytics_solution_id
}