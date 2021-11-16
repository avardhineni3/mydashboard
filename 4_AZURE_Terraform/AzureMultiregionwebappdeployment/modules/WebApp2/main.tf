# Create App Service Plan

resource "azurerm_app_service_plan" "cmp_asp2" {
  name                = "${var.web2}-asp"
  location            = var.loc2
  resource_group_name = var.rg2

  sku {
    tier = "Free"
    size = "F1"
  }
}


# Create App Service

resource "azurerm_app_service" "cmp_web2" {
  name                = var.web2
  location            = var.loc2
  resource_group_name = var.rg2
  app_service_plan_id = "${azurerm_app_service_plan.cmp_asp2.id}"
   tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }

}