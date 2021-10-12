

resource "azurerm_resource_group" "cmp" {
  name     = var.rgname
  location = var.location
  tags = {
    Name         = var.stname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
  }
}

resource "azurerm_storage_account" "cmp" {
  name                     = var.stname
  resource_group_name      = azurerm_resource_group.cmp.name
  location                 = azurerm_resource_group.cmp.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    Name         = var.stname,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
  }
}

resource "azurerm_storage_container" "cmp" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.cmp.name
  container_access_type = "private"

}

resource "azurerm_storage_blob" "cmp" {
  name                   = var.blobname
  storage_account_name   = azurerm_storage_account.cmp.name
  storage_container_name = azurerm_storage_container.cmp.name
  type                   = "Block"
}
resource "azurerm_monitor_diagnostic_setting" "stlogs" {
  name                       = "Vnet diagnostic logs"
  target_resource_id         = azurerm_storage_account.cmp.id
  log_analytics_workspace_id = "  "
  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
    }
  }
}
resource "azurerm_monitor_diagnostic_setting" "bloblogs" {
  name                       = "Vnet diagnostic logs"
  target_resource_id         = azurerm_storage_account.cmp.id
  log_analytics_workspace_id = "  "
  log {
    category = "StorageRead"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
    }
  }
}

