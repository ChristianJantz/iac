provider "azurerm" {
  features {
    
  }
  subscription_id = var.sp-subscription-id
}
resource "azurerm_resource_group" "workspace" {
  name = "rg-workspace-test-gwc"
  location = "germanywestcentral"
}

module "workspace" {
  
    source = "../../"

    # if workspace exists 
    # log_analytics_workspace = {
    #     id = ""
    #     name = ""
    #     location = ""
    #     resource_group_name = ""
    # }
    
    #
    name = "ds-workbench"
    location = azurerm_resource_group.workspace.location
    resource_group_name = azurerm_resource_group.workspace.name
    log_retention_in_days = 35 
    #log_analytics_workspace_sku = "PerGB2018"


    # SOLUTION PLAN CONFIGURATION
    solution_plan_map = {
      ContainerInsights = {
        product = "OMSGallery/ContainerInsights"
        publisher = "Microsoft"
      }
    }
}