variable "name" {
  type = string
  description = "Name of the Workspace"
}
variable "location" {
  type = string
  default = "germanywestcentral"
  description = "Location of the Workspace. Default is set to 'germanywestcentral'"

  validation {
    condition = contains(["germanywestcentral", "germanynorth", "westeurope", "northeurope"], var.location)
    error_message = "The posible locations are 'germanywestcentral', 'germanynorth', 'westeurope' and 'northeurope'"
  }
}
variable "resource_group_name" {
  type = string
  description = "The resource group name to be imported"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Any tags that should be present on the AKS cluster resources"
}

variable "log_analytics_workspace" {
  type = object({
    id = string
    name = string
    location = optional(string)
    resource_group_name = optional(string)
  })
  default = null
  description = "(Optional) Existing azurerm_log_analytics_workspace to attach azurerm_log_analytics_solution. Providing the config disables creation of azurerm_log_analytics_workspace."
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"

  validation {
    condition = contains(["Free", "PerGB2018", "PerNode", "Standalone"], var.log_analytics_workspace_sku)
    error_message = "The log Analytics sku is incorrect"
  }
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "The retention period for the logs in days"
}
variable "log_analytics_solution" {
  type = object({
    id = string
  })
  default     = null
  description = "(Optional) Object which contains existing azurerm_log_analytics_solution ID. Providing ID disables creation of azurerm_log_analytics_solution."

  validation {
    condition     = var.log_analytics_solution == null ? true : var.log_analytics_solution.id != null && var.log_analytics_solution.id != ""
    error_message = "`var.log_analytics_solution` must be `null` or an object with a valid `id`."
  }
}

variable "solution_plan_map" {
  type = map(any)
  description = "(Required) Specifies the solutions to deploy to log analytics workspace"
  default = {
    ContainerInsights = {
      publisher = "Mircosoft"
      product = "OMSGallery/ContainerInsights"
    }
  }
}

variable "suffix" {
  type = string
  default = "workspace"
  description = "Suffix name for the worspace "
}