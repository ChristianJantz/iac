variable "name" {
  type = string
  description = "Name of the network security group"
}
variable "location" {
  type = string
  default = "germanywestcentral"
  description = "Location of the network security group. Default is set to 'germanywestcentral'"

  validation {
    condition = contains(["germanywestcentral", "germanynorth", "westeurope", "northeurope"], var.location)
    error_message = "The posible locations are 'germanywestcentral', 'germanynorth', 'westeurope' and 'northeurope'"
  }
}
variable "resource_group_name" {
  type = string
  description = "The resource group name to be imported"
}
variable "snet_id" {
  type = string
  description = "The subnet ID to allocate the network security group"
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "list of network security group rules ."
  
}
variable "suffix" {
    type = string
    default = "_nsg"
    description = "suffix name for the network security group"
}
