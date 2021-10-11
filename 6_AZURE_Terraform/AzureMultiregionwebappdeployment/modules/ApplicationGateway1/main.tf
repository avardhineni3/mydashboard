resource "azurerm_virtual_network" "cmp_vnet1" {
  name                = "${var.ag1name}-network"
  resource_group_name = var.rg1
  location            = var.loc1
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = var.rg1
  virtual_network_name = azurerm_virtual_network.cmp_vnet1.name
  address_prefixes     = ["10.0.0.0/24" ]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = var.rg1
  virtual_network_name = azurerm_virtual_network.cmp_vnet1.name
  address_prefixes     = ["10.0.2.0/24" ]
}

resource "azurerm_public_ip" "cmp" {
  name                = "${var.ag1name}-pubip"
  resource_group_name = var.rg1
  location            = azurerm_virtual_network.cmp_vnet1.location
  allocation_method   = "Dynamic"

  tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }
  
}

resource "azurerm_application_gateway" "network" {
  name                = var.ag1name
  resource_group_name = var.rg1
  location            = var.loc1

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
    name      = "${var.ag1name}-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.ag1name}-frontendip"
    public_ip_address_id = azurerm_public_ip.cmp.id
  }

  backend_address_pool {
    name        = "AppService"
    fqdns       = ["${var.web1fqdn}.azurewebsites.net"]
  }

  http_listener {
    name                           = "http"
    frontend_ip_configuration_name = "${var.ag1name}-frontendip"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  probe {
    name                = "probe"
    protocol            = "http"
    path                = "/"
    host                = "${var.web1fqdn}.azurewebsites.net"
    interval            = "30"
    timeout             = "30"
    unhealthy_threshold = "3"
  }

  backend_http_settings {
    name                  = "http"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 5
    probe_name            = "probe"
    pick_host_name_from_backend_address = "true"
  }

  request_routing_rule {
    name                       = "http"
    rule_type                  = "Basic"
    http_listener_name         = "http"
    backend_address_pool_name  = "AppService"
    backend_http_settings_name = "http"
  }

   tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }

}

resource "azurerm_log_analytics_workspace" "cmp" {

  name                = "${var.ag1name}-laws"
  location            = var.loc1
  resource_group_name = var.rg1
  sku                 = "PerGB2018"
  retention_in_days   = 30

}

resource "azurerm_monitor_diagnostic_setting" "cmp" {

  name                           = "${var.ag1name}-diag"
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
