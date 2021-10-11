resource "azurerm_resource_group" "cmp_rg1" {
  name     = var.rg1
  location = var.loc1

   tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }
  
}

resource "azurerm_resource_group" "cmp_rg2" {
  name     = var.rg2
  location = var.loc2

    tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }
  

}

resource "azurerm_resource_group" "cmp_rgglobal" {
  name     = var.rgglobal
  location = var.locglobal

     tags = {
    Owner        = var.tag_owner,
    Environment  = var.tag_environment,
    BusinessUnit = var.tag_businessunit,
    Application  = var.tag_application,
  }
  

}
