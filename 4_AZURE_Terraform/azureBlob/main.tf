resource "azurerm_storage_account" "cmp" {
  name                     = var.storage_account
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "cmp" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.cmp.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "cmp" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.cmp.name
  storage_container_name = azurerm_storage_container.cmp.name
  type                   = "Block"
}
