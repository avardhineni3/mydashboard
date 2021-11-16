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
  name                = "${var.ag_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.cmp.name
  virtual_network_name = azurerm_virtual_network.cmp.name
  address_prefixes     = ["10.0.0.0/24" ]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.cmp.name
  virtual_network_name = azurerm_virtual_network.cmp.name
  address_prefixes     = ["10.0.2.0/24" ]
}

resource "azurerm_public_ip" "cmp" {
  name                = "${var.ag_name}-pubip"
  resource_group_name = azurerm_resource_group.cmp.name
  location            = azurerm_resource_group.cmp.location
  allocation_method   = "Dynamic"

  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

}


locals {
  backend_address_pool_name      = "${azurerm_virtual_network.cmp.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.cmp.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.cmp.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.cmp.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.cmp.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.cmp.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.cmp.name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = var.ag_name
  resource_group_name = azurerm_resource_group.cmp.name
  location            = azurerm_resource_group.cmp.location

  sku {
    name     = "WAF_Medium"
    tier     = "WAF"
    capacity = 2
  }

  waf_configuration {
     firewall_mode = "Detection"
     rule_set_type = "OWASP"
     rule_set_version = "2.2.9"
     enabled = true
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.cmp.id
  }

frontend_ip_configuration {
    name                          = "${local.frontend_ip_configuration_name}-private"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
}

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
  tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

}

resource "azurerm_log_analytics_workspace" "cmp" {

  name                = "${var.ag_name}-laws"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

}

resource "azurerm_monitor_diagnostic_setting" "cmp" {

  name                           = "${var.ag_name}-diag"
  target_resource_id             = azurerm_application_gateway.network.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.cmp.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }

  }
  log {
    category = "ApplicationGatewayAccessLog"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }


}