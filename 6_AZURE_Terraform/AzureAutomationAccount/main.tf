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

resource "azurerm_automation_account" "cmp" {
  name                = var.AutomationAccountName
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name

  sku_name = "Basic"

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}