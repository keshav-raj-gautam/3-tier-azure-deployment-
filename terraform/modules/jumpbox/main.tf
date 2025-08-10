resource "azurerm_network_interface" "jumpbox-nic" {
  name                = "Jumpbox-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jumpbox-pip.id
  }
}

resource "azurerm_public_ip" "jumpbox-pip" {
  location = var.location
  resource_group_name = var.resource_group_name
  name = var.jumpbox_pip_name
  allocation_method = "Static"
  
}
resource "azurerm_linux_virtual_machine" "name" {
  name = "Jumpbox-vm"
  resource_group_name = var.resource_group_name
  location = var.location
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  size = "Standard_b1s"
  admin_username = var.username

  admin_ssh_key {
 username = var.username
 public_key = file(var.key_path)
}


network_interface_ids = [azurerm_network_interface.jumpbox-nic.id]

}