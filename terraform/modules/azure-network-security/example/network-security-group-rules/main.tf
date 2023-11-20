provider "azurerm" {
  features {
    
  }
  subscription_id = var.sp-subscription-id
}
resource "azurerm_resource_group" "test" {
  name = "rg-nsg-test-gwc"
  location = "germanywestcentral"
}

resource "azurerm_virtual_network" "test" {
  resource_group_name = azurerm_resource_group.test.name
  location = azurerm_resource_group.test.location
  name = "vnet-nsgtest"
  address_space = ["10.0.0.0/16"]

    subnet  {
        name = "subnet1"
        address_prefix = "10.0.1.0/24"
    }
    subnet {
        name = "subnet2"
        address_prefix = "10.0.2.0/24"
    }
}
data "azurerm_subnet" "allocate" {
  name = "subnet2"
  resource_group_name = azurerm_virtual_network.test.resource_group_name
  virtual_network_name = azurerm_virtual_network.test.name
}

module "nsg" {
    source = "../../"

    # variables
    name = "testtry-nsg"
    location = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
    snet_id = data.azurerm_subnet.allocate.id
    nsg_rules = [
        {
            name                       = "AllowInboundSSH"
            priority                   = 110
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        },
        {
            name                       = "AllowInboundHTTP"
            priority                   = 200
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "80"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        },
        {
            name                       = "AllowOutboundInternet"
            priority                   = 100
            direction                  = "Outbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            destination_port_range     = "*"
            source_address_prefix      = "*"
            destination_address_prefix = "Internet"
        },
        {
            name                       = "AllowInboundHTTPS"
            priority                   = 210
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_port_range          = "*"
            destination_port_range     = "443"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
        },
      ]
  # dependence 
  depends_on = [ azurerm_resource_group.test, azurerm_virtual_network.test ]
}
