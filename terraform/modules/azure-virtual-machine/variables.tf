variable "admin_username" {
  description = "Admin Benutzername für die Linux VM"
  type        = string
}

variable "admin_password" {
  description = "Admin Passwort für die Linux VM"
  type        = string
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

variable "vm_resource_group_name" {
  type        = string
  description = "Name of vm resource group"
}

variable "vm_name" {
  type        = string
  description = "Name of vm"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet"
}

variable "storage_image_version" {
  type        = string
  description = "Image version of the storage"
}

variable "storage_image_sku" {
  type        = string
  description = "SKU of the storage"
  default     = "22_04-lts-gen2"
}

variable "storage_image_offer" {
  type        = string
  description = "Offer of the storage image"
  default     = "0001-com-ubuntu-server-jammy"
}

variable "storage_image_publisher" {
  type        = string
  description = "Publisher of the storage image"
  default     = "Canonical"
}

variable "vm_size" {
  type        = string
  description = "Size of the vm"
  default     = "standard_D2s_v3"
}

# variable "vm_network_interface_ids" {
#     type = optinal(list(string))
#     description = "Id's of the network interface for the vm"
# }

variable "tags" {
  description = "Tags for the vm"
  type        = map(any)
}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "workbench"
}

variable "data_sa_type" {
  description = "Data Disk Storage Account type. Default is set to 'Standard_LRS'."
  type        = string
  default     = "Standard_LRS"
}

# variable "ssh_key" {
#   description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
#   type = string
#   default     = "~/.ssh/id_rsa.pub"
# }
variable "vm_zones" {
  type = list(string)
  default = []
  description = "Specifies the avaibility zone"
}