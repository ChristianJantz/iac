variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created"
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network. Changing this forces a new resource to be created"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space"
}

variable "subnets" {
  # type        = map(any)
  description = "Each subnet will create an object that contain fields"
  default     = {}
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
