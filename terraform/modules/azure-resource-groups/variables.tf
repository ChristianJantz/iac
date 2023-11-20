variable "resource_groups" {
  description = "Each resource group will create an object"
  default     = {}
}
variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
