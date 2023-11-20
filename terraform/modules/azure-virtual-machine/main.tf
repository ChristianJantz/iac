
resource "azurerm_public_ip" "linux_vm" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.vm_resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "linux_vm" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.vm_resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_vm.id
  }
}

resource "azurerm_virtual_machine" "linux_vm" {
  depends_on            = [azurerm_network_interface.linux_vm, azurerm_public_ip.linux_vm]
  name                  = lower("${var.vm_name}-${var.project}")
  location              = var.location
  resource_group_name   = var.vm_resource_group_name
  network_interface_ids = [azurerm_network_interface.linux_vm.id]
  vm_size               = var.vm_size
  zones = var.vm_zones

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.data_sa_type
  }

  storage_image_reference {
    publisher = var.storage_image_publisher
    offer     = var.storage_image_offer
    sku       = var.storage_image_sku
    version   = var.storage_image_version
  }

  os_profile {
    computer_name  = "${var.vm_name}-linux"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false

    # ssh_keys {
    #   path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    #   key_data = "${file("${var.ssh_key}")}"
    # }
  }

  tags = var.tags
}