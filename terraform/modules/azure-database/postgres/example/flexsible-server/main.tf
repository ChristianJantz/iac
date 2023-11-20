provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "default" {
  name     = "psqlfstest-gwc"
  location = "germanywestcentral"
}

resource "azurerm_virtual_network" "default" {
  name                = "psqlfstest-vnet"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_network_security_group" "default" {
  name                = "psqlfstest-nsg"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "default" {
  name                 = "psqlfstest-subnet"
  virtual_network_name = azurerm_virtual_network.default.name
  resource_group_name  = azurerm_resource_group.default.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}


module "psqlfstest" {
  source = "../../"

  server_name         = "dsworkpsqltest"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  delegated_subnet_id = azurerm_subnet.default.id
  psql_vnet_id        = azurerm_virtual_network.default.id
  psql_subnet_id      = azurerm_subnet.default.id

  postgres_version = "14"
}