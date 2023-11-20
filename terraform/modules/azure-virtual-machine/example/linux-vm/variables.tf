variable "admin_username" {
  description = "Admin Benutzername für die Linux VM"
  type        = string
  # default     = ""
}

variable "admin_password" {
  description = "Admin Passwort für die Linux VM"
  type        = string
  # default     = ""
}

variable "location" {
  type        = string
  default     = "germanywestcentral"
  description = "Location of the VM Ressources. Default is set to 'germanywestcentral'"

  validation {
    condition     = contains(["germanywestcentral", "germanynorth", "westeurope", "northeurope"], var.location)
    error_message = "The posible locations are 'germanywestcentral', 'germanynorth', 'westeurope' and 'northeurope'"
  }
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  # default     = ""
}