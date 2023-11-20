
variable "location" {
    type = string
    description = "Location for the flexsible Postgres Server"
}
variable "server_name" {
    type = string
    description = "Name for the flexsinle Postgres Database Server"
}
variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}
variable "psql_vnet_id" {
    type = string
    description = "The ID of the virtual network "
}
variable "psql_subnet_id" {
  type = string
  description = "The ID of the delegated Subnet for the postgres server"
}
variable "administrator_login" {
  type = string
  default = "adminTerraform"
  description = "Administrator login name for the flexsible postgres server"
}
variable "administrator_login_password" {
  type = string
  default = "postgres-flex14!"
  description = "The Password for the Admin Login"
}
variable "delegated_subnet_id" {
  type = string
    description = "The ID of the delegated Subnet"
}
variable "postgres_version" {
    type = string
    default = "14"
    description = "Postgres verion .Default is set to '14' "
}
variable "geo_redundant_backup_enabled" {
  type = bool
  default = false
  description = "Enable Geo redundant Backup Default is set to 'false'"
}
variable "sku_name" {
    type = string
    description = "Specifies the VM Size for the flexsible Postgres Server. Default is set to 'GP_Standard_D2s_v3'"
    default = "GP_Standard_D2s_v3"
}
variable "storage_mb" {
  type = number
  default = 32768
  description = "the Storage Gib for the Postgres Server Default is '32768'"

  validation {
    condition = contains([32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216], var.storage_mb)
    error_message = "posible values are [32768, 65536, 131072, 262144, 524288,1048576, 2097152, 4194304, 8388608, 16777216]."
  }
}
variable "backup_retention_days" {
  type = number
  default = 7
  description = "specifies  the backup rentention. the default is 7 days "
}
variable "psql_zone" {
  type = string
  default = "1"
  description = "Specifies the avablitity zone for the postgres server"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Any tags that should be present on the psql cluster resources"
}
