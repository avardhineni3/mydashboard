# Create App Service Plan

resource "azurerm_app_service_plan" "cmp_asp1" {
  name                = "${var.web1}-asp"
  location            = var.loc1
  resource_group_name = var.rg1

  sku {
    tier = "Free"
    size = "F1"
  }
}


# Create App Service

resource "azurerm_app_service" "cmp_web1" {
  name                = var.web1
  location            = var.loc1
  resource_group_name = var.rg1
  app_service_plan_id = "${azurerm_app_service_plan.cmp_asp1.id}"
   tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }

}