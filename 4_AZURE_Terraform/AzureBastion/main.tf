resource "azurerm_resource_group" "cmp" {
  name     = var.rgname
  location = var.location

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_virtual_network" "cmp" {
  name                = "${var.bastionhostname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
}

resource "azurerm_subnet" "cmp" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.cmp.name
  virtual_network_name = azurerm_virtual_network.cmp.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "cmp" {
  name                = "${var.bastionhostname}-pubip"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  allocation_method   = "Static"
  sku                 = "Standard"
   
   tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_bastion_host" "cmp" {
  name                = var.bastionhostname
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name

  ip_configuration {
    name                 = "Ip_Configuration"
    subnet_id            = azurerm_subnet.cmp.id
    public_ip_address_id = azurerm_public_ip.cmp.id
  }

 tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}