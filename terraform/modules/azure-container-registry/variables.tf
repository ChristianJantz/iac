variable "acr_name" {
  type        = string
  description = "The name of the Azure Container Registry"
}

variable "location" {
  type        = string
  description = "Region of the Azure Resources"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}

variable "acr_sku_tier" {
  type        = string
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  default     = "Standard"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for the container registry"
  default     = false
}

variable "admin_enabled" {
  type        = string
  description = "Specifies whether the admin user is enabled."
  default     = "false"
}

variable "acr_georeplications" {
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool)
  }))
  default     = []
  description = "A list of Azure locations where the container registry should be geo-replicated"
}

variable "vnet_id" {
  type        = string
  description = "The ID of the Virtual Network"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  default     = []
  description = "The private DNS zone ID for the Private Endpoint"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
