resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = each.value.resource_group_name
  location = lookup(each.value, "location")
  tags = var.tags
}
