resource "azurerm_virtual_network" "linux_vm" {
  depends_on          = [azurerm_resource_group.linux_vm]
  name                = "VM-Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.linux_vm.name
}

resource "azurerm_subnet" "linux_vm" {
  depends_on           = [azurerm_virtual_network.linux_vm]
  name                 = "VM-Subnet"
  resource_group_name  = azurerm_resource_group.linux_vm.name
  virtual_network_name = azurerm_virtual_network.linux_vm.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_resource_group" "linux_vm" {
  name     = "linux-vm-resources"
  location = var.location
}

module "linux_vm" {
  source = "../../"

  subnet_id = azurerm_subnet.linux_vm.id
  // == not in use at the moment
  #network_interface_ids    = []
  // == vm config ==
  vm_name                = "linux-vm-test"
  vm_resource_group_name = azurerm_resource_group.linux_vm.name
  location               = azurerm_resource_group.linux_vm.location
  storage_image_version  = "latest"
  storage_image_sku      = "22_04-lts-gen2"
  storage_image_offer    = "0001-com-ubuntu-server-jammy"
  admin_password         = var.admin_password
  admin_username         = var.admin_username
  vm_zones = [ "3" ]
  tags = {
    project = "project-test"
  }
}