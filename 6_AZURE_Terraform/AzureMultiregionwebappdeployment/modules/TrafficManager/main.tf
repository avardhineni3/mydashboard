# Create Traffic Manager API Profile

resource "azurerm_traffic_manager_profile" "Traffic_Manager" {
  name                   = var.tfmname
  resource_group_name    = var.rgglobal
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = var.tfmname
    ttl           = 300
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }

   tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }

}


# Create Traffic Manager End Point - Region1

resource "azurerm_traffic_manager_endpoint" "tm-endpoint-region1" {
  name                = "Region1_Endpoint"
  resource_group_name = var.rgglobal
  profile_name        = azurerm_traffic_manager_profile.Traffic_Manager.name
  type                = "azureEndpoints"
  target_resource_id  = var.target1
  endpoint_location   = var.endpoint_loc1
}

# Create Traffic Manager End Point - Region2
resource "azurerm_traffic_manager_endpoint" "tm-endpoint-region2" {
  name                = "Region2_Endpoint"
  resource_group_name = var.rgglobal
  profile_name        = azurerm_traffic_manager_profile.Traffic_Manager.name
  type                = "azureEndpoints"
  target_resource_id  = var.target2
  endpoint_location   = var.endpoint_loc2
}