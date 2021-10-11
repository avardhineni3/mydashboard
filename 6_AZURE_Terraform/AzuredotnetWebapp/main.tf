# Create ResourceGroup
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


# Create app service plan
resource "azurerm_app_service_plan" "plan" {
  name                = "${var.webappname}_asp"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  kind                = "Windows"

   sku {
        tier = var.tier
        size = var.sku
    }

   tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

}

# Create application insights
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.webappname}_AppInsight_${var.environment}"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  application_type    = "web"


tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }
}

# Create app service
resource "azurerm_app_service" "webapp" {
  name                = "${var.webappname}-${var.environment}"
  location            = azurerm_resource_group.cmp.location
  resource_group_name = azurerm_resource_group.cmp.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  https_only          = true
  
 
tags = {
    Owner        = var.owner,
    Environment  = var.environment,
    BusinessUnit = var.businessunit,
    Application  = var.application,
  }

  site_config {
    dotnet_framework_version = var.dotnetframeworkversion
    ftps_state               = "Disabled"
    min_tls_version          = "1.2"
    always_on                = true
    default_documents        = ["hostingstart.html"]
    
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.appinsights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = azurerm_application_insights.appinsights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
    "XDT_MicrosoftApplicationInsights_Mode"           = "default"
  }
}