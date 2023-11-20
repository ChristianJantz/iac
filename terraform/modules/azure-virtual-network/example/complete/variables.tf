# variable "location" {
#   type        = string
#   description = "The Azure Location where the VNet will be deployed"
# }

# variable "create_resource_group" {
#   type        = bool
#   description = "Whether to create resource group and use it for all networking resources"
#   default     = false
# }

# variable "resource_group_name" {
#   type        = string
#   description = "Resource Group Name where the VNet will be placed in"
# }

# variable "vnet_name" {
#   type        = string
#   description = "The VNet name"
# }

# variable "vnet_address_space" {
#   type        = list(string)
#   description = "The address space to be used for the Azure virtual network."
#   default     = [""]
# }

# variable "subnets" {
#   type        = map(string)
#   description = "For each subnet, create an object that contain fields"
#   default     = {}
# }

# variable "subnet_name" {
#   type        = string
#   description = "The Subnet name"
# }
