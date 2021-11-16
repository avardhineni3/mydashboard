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


resource "azurerm_traffic_manager_profile" "cmp" {
  name                   = var.tfmname
  resource_group_name    = azurerm_resource_group.cmp.name
  traffic_routing_method = var.routingmethod

  dns_config {
    relative_name = var.tfmname
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
  
  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}