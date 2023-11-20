provider "azurerm" {
  features {
    
  }
  subscription_id = var.sp-subscription-id
}
provider "azuread" {
  
}

data "azuread_group" "aks_admins" {
    display_name = "infrastructure admin"
}
data "azuread_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name = "rg-dsw-example-gwc"
  location = "germanywestcentral"
}
resource "azurerm_virtual_network" "example" {
  depends_on = [ azurerm_resource_group.example ]
  name = "test-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location = azurerm_resource_group.example.location
  address_space = [ "10.10.0.0/16" ]
  
  subnet  {
    name = "snet-overlay"
    address_prefix = "10.10.1.0/24"
  }
}
data "azurerm_subnet" "example" {
  depends_on = [ azurerm_virtual_network.example ]
  name = "snet-overlay"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
}

module "dscluster" {
  source = "../../"

  aks_name = "aksrbacgwc"
  aks_rg_name = azurerm_resource_group.example.name
  aks_region_location = azurerm_resource_group.example.location
  aks_sku_tier = "Standard"
  network_profile_network_plugin = "azure"
  
  network_profile_snet_dns_service_ip = "10.10.1.10"
  network_profile_snet_service_cidr = "10.10.1.0/24"
  enable_auto_scaling = true

  aks_local_account_disabled = true
  role_based_access_control_enabled = true
  rbac_aad_azure_rbac_enabled = false # set the authentication and authorization to "Azure AD auth. with Kubernetes RBAC"
  rbac_aad_managed = true
  rbac_aad_admin_group_object_ids = ["${data.azuread_group.aks_admins.object_id}"]
  rbac_aad_tenant_id = data.azuread_client_config.current.tenant_id

  log_analytics_workspace_enabled = false

  microsoft_defender_enabled = false

  log_analytics_workspace_id = ""
  
  agents_pool_name = "sys"
  agents_min_count = 1
  agents_max_count = 2

  node_pools = {
    frontend = {
      name = "frontend"
      mode = "User"
      vm_size = "Standard_D2s_v3"
      min_count = 1
      max_count = 2
      max_pods = 40
      enable_auto_scaling = true
      
    }
    calc = {
      name = "calcpool"
      vm_size = "Standard_D8s_v3"
      min_count = 1
      max_count = 4
      max_pods = 200
      enable_auto_scaling = true
    }
    result = {
      name = "resultpool"
      vm_size = "Standard_D2s_v3"
      min_count = 1
      max_count = 2
      max_pods = 10
      enable_auto_scaling = true
    }
  }
}