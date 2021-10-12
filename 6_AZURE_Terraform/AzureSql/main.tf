resource "azurerm_resource_group" "cmp" {
  name     = var.rgname
  location = var.location
  tags = {
    Name         = var.sqlservername,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
  }
}

resource "azurerm_sql_server" "cmp" {
  name                         = var.sqlservername
  resource_group_name          = azurerm_resource_group.cmp.name
  location                     = azurerm_resource_group.cmp.location
  version                      = "12.0"
  administrator_login          = var.username
  administrator_login_password = var.password
  extended_auditing_policy {
    storage_endpoint                        = "https://cmpmonitorst.blob.core.windows.net/"
    storage_account_access_key              = ""
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 91
  }
  tags = {
    Name         = var.sqlservername,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
  }
}

/*resource "azurerm_sql_firewall_rule" "cmp" {
  count               = length(var.firewallrules)
  name                = "FirewallRule-${count.index}"
  resource_group_name = azurerm_resource_group.cmp.name
  server_name         = azurerm_sql_server.cmp.name
  start_ip_address    = lookup(element(var.firewallrules, count.index), "startip")
  end_ip_address      = lookup(element(var.firewallrules, count.index), "endip")
}*/

resource "azurerm_mssql_database" "cmp" {
  name           = var.dbname
  server_id      = azurerm_sql_server.cmp.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.dbsize
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = false

  tags = {
    Name         = var.sqlservername,
    Owner        = var.owner,
    Environment  = var.Environment,
    BuisnessUnit = var.Buisness_unit,
    Application  = var.Application,
  }
  extended_auditing_policy {
    storage_endpoint                        = "https://cmpmonitorst.blob.core.windows.net/"
    storage_account_access_key              = ""
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 91
  }
}
resource "azurerm_monitor_diagnostic_setting" "sqldblogs" {
  name                       = "SQL DB diagnostic logs"
  target_resource_id         = azurerm_mssql_database.cmp.id
  log_analytics_workspace_id = ""
  log {
    category = "SQLInsights"
    enabled  = true
  }
  log {
    category = "Errors"
    enabled  = true
  }
  log {
    category = "Deadlocks"
    enabled  = true
  }
  log {
    category = "Blocks"
    enabled  = true
  }
  metric {
    category = "Basic"

    retention_policy {
      enabled = true
    }
  }
}

