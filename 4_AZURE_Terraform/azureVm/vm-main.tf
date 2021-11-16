resource "azurerm_resource_group" "cmp" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_virtual_network" "cmp" {
  name                = "${var.vmname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.cmp.name
  virtual_network_name = azurerm_virtual_network.cmp.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "cmp" {
  name                = "${var.vmname}-nic"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_managed_disk" "cmp" {
  name                 = "${var.vmname}-disk1"
  location             = azurerm_resource_group.cmp.location
  resource_group_name  = azurerm_resource_group.cmp.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}
resource "azurerm_network_security_group" "cmp" {
  name                = "${var.vmname}-nsg"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name         = var.vmname,
    Owner        = var.owner,
    Environment  = var.Enviorment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
    Platform     = var.Platform,
    Type         = var.Type,
  }
}
resource "azurerm_virtual_machine" "cmp" {
  name                  = "${var.vmname}-vm"
  location              = azurerm_resource_group.cmp.location
  resource_group_name   = azurerm_resource_group.cmp.name
  network_interface_ids = [azurerm_network_interface.cmp.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data    = file("install_apache.sh")
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    Name         = var.vmname,
    Owner        = var.owner,
    Environment  = var.Enviorment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
    Platform     = var.Platform,
    Type         = var.Type,
  }
}
resource "azurerm_network_interface_security_group_association" "cmp" {
  network_interface_id      = azurerm_network_interface.cmp.id
  network_security_group_id = azurerm_network_security_group.cmp.id
}
resource "azurerm_virtual_machine_data_disk_attachment" "cmp" {
  managed_disk_id    = azurerm_managed_disk.cmp.id
  virtual_machine_id = azurerm_virtual_machine.cmp.id
  lun                = "10"
  caching            = "ReadWrite"
}


