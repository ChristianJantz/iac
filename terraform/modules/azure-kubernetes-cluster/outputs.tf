output "aks_mc_resourcegroup_name" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}
output "aksname_out" {
  description = "Name of the Kubernetes Cluster"
  value = azurerm_kubernetes_cluster.aks.name
}
output "aks_rg_out" {
  description = "Resource group name for the Kubernetes Cluster"
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "aks_object_id_out" {
  description = "Object ID of the Kubernetes cluster"
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
output "aks_principal_id_out" {
  description = "Principal object ID of the AKS"
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
output "log_analytics_workspace_id" {
  description = "Log analytics workspace id "
  value = try(azurerm_kubernetes_cluster.aks.oms_agent[0].log_analytics_workspace_id, null)
}
output "oms_agent" {
  description = "The `azurerm_kubernetes_cluster`'s `oms_agent` argument."
  value = try(azurerm_kubernetes_cluster.aks.oms_agent[0], null)
}
output "network_profile" {
  description = "The `azurerm_kubernetes_cluster`'s `network_profile` block"
  value = azurerm_kubernetes_cluster.aks.network_profile
}
output "cluster_fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster."
  value       = azurerm_kubernetes_cluster.aks.fqdn
}
output "cluster_identity" {
  description = "The `azurerm_kubernetes_cluster`'s `identity` block."
  value       = try(azurerm_kubernetes_cluster.aks.identity[0], null)
}
