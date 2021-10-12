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

resource "azurerm_servicebus_namespace" "cmp" {
  name                = var.servicebusname
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  sku                 = "Standard"

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

resource "azurerm_servicebus_queue" "cmp" {
  name                = "${var.servicebusname}_queue"
  resource_group_name = azurerm_resource_group.cmp.name
  namespace_name      = azurerm_servicebus_namespace.cmp.name
  enable_partitioning = false
}

resource "azurerm_servicebus_topic" "cmp" {
  name                = "${var.servicebusname}_topic"
  resource_group_name = azurerm_resource_group.cmp.name
  namespace_name      = azurerm_servicebus_namespace.cmp.name
  enable_partitioning = false
}