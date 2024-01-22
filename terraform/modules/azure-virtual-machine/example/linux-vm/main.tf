resource "azurerm_virtual_network" "linux_vm" {
  depends_on          = [azurerm_resource_group.linux_vm]
  name                = "VM-Vnet"
  address_space       = ["10.5.0.0/16"]
  location            = "germanywestcentral"
  resource_group_name = azurerm_resource_group.linux_vm.name
}

resource "azurerm_subnet" "linux_vm" {
  depends_on           = [azurerm_virtual_network.linux_vm]
  name                 = "VM-Subnet"
  resource_group_name  = azurerm_resource_group.linux_vm.name
  virtual_network_name = azurerm_virtual_network.linux_vm.name
  address_prefixes     = ["10.5.2.0/24"]
}

resource "azurerm_public_ip" "linux_vm" {
  name = "linux-vm-public-ip"
  resource_group_name = azurerm_resource_group.linux_vm.name
    location = azurerm_resource_group.linux_vm.location
    allocation_method = "Dynamic"
}
resource "azurerm_resource_group" "linux_vm" {
  name     = "linux-vm-resources"
  location = "germanywestcentral"
}


resource "azurerm_network_interface" "base_nic" {
    depends_on = [ azurerm_resource_group.linux_vm, azurerm_subnet.linux_vm ]
  name                = "linux-test-nic"
  location            = azurerm_resource_group.linux_vm.location
  resource_group_name = azurerm_resource_group.linux_vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux_vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_vm.id
  }
}

module "azure-vm-linux" {
    depends_on = [ azurerm_resource_group.linux_vm, azurerm_network_interface.base_nic ]
    source = "../.."

    disable_password_authentication = false
    name = "linuntest"
    resource_group_name = azurerm_resource_group.linux_vm.name
    location = azurerm_resource_group.linux_vm.location
    network_interface_ids = [azurerm_network_interface.base_nic.id]
    size = "standard_B1s"
    admin_username = "testuser"
    admin_password = "testpassword!1234"
    custom_data = filebase64("vm-init.tpl")
    computer_name = "b1s-vm-linux"
    tags = {
        project = "testprojekt"
    }
    
    os_disk = {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    identity = {
        type = "SystemAssigned"
    }
    
}

