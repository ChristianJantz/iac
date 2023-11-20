
resource "azurerm_network_security_group" "main" {
    name = lower("${try(trim(var.name, "_nsg"), var.name)}${var.suffix}")
    location = var.location
    resource_group_name = var.resource_group_name

    dynamic "security_rule" {
        for_each = var.nsg_rules
        content {
            name                       = lookup(security_rule.value, "name")
            priority                   = lookup(security_rule.value, "priority")
            direction                  = lookup(security_rule.value, "direction")
            access                     = lookup(security_rule.value, "access")
            protocol                   = lookup(security_rule.value, "protocol", "Tcp")
            source_port_range          = lookup(security_rule.value, "source_port_range", "*")
            destination_port_range     = lookup(security_rule.value, "destination_port_range", "*")
            source_address_prefix      = lookup(security_rule.value, "source_address_prefix", "*")
            destination_address_prefix = lookup(security_rule.value, "destination_address_prefix", "*")
            
        }
    }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {

  subnet_id                 = var.snet_id
  network_security_group_id = azurerm_network_security_group.main.id
}