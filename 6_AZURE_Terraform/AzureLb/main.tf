resource "azurerm_resource_group" "cmp" {
  name     = var.lbname
  location = var.location
  tags = {
    Name         = var.lbname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,

  }
}

resource "azurerm_public_ip" "cmp" {
  name                = "PublicIPForLB"
  location            = var.location
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.cmp.name
  allocation_method   = "Static"
  tags = {
    Name         = var.lbname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,

  }
}

resource "azurerm_lb" "cmp" {
  name                = var.lbname
  location            = var.location
  resource_group_name = azurerm_resource_group.cmp.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.cmp.id
  }

  tags = {
    Name         = var.lbname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,

  }
}
resource "azurerm_lb_backend_address_pool" "cmp" {
  loadbalancer_id     = azurerm_lb.cmp.id
  for_each            = toset(var.backendpools)
  name                = each.key
  resource_group_name = azurerm_lb.cmp.name
}
resource "azurerm_lb_rule" "cmp" {
  count                          = length(var.lbrules)
  resource_group_name            = azurerm_resource_group.cmp.name
  loadbalancer_id                = azurerm_lb.cmp.id
  name                           = "LBRule-${count.index}"
  protocol                       = "Tcp"
  frontend_port                  = lookup(element(var.lbrules, count.index), "frontendport")
  backend_port                   = lookup(element(var.lbrules, count.index), "backendport")
  frontend_ip_configuration_name = "PublicIPAddress"
}

