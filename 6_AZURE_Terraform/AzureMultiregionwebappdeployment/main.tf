module "ResourceGroups" {
  source                 = "./modules/ResourceGroups"
  rg1                    =  var.rgname1
  rg2                    = var.rgname2
  rgglobal               = var.rgglobal
  loc1                   = var.location1
  loc2                   = var.location2
  locglobal              = var.locationglobal
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application
 
}

module "WebApp1" {
  source                 = "./modules/WebApp1"
  rg1		                 = module.ResourceGroups.rg1name
  loc1                   = var.location1
  web1                   = var.webapp1
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application
}

module "WebApp2" {
  source                 = "./modules/WebApp2"
  rg2                    = module.ResourceGroups.rg2name
  loc2                   = var.location2
  web2                   = var.webapp2
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application
}

module "ApplicationGateway1" {
  source                 = "./modules/ApplicationGateway1"
  rg1                    = module.ResourceGroups.rg1name
  loc1                   = var.location1
  ag1name                = "${var.webapp1}-agw"
  web1fqdn               = var.webapp1
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application
}
module "ApplicationGateway2" {
  source                 = "./modules/ApplicationGateway2"
  rg2                    = module.ResourceGroups.rg2name
  loc2                   = var.location2
  ag2name                = "${var.webapp2}-agw"
  web2fqdn               = var.webapp2
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application
}

module "TrafficManager" {
  source                 = "./modules/TrafficManager"
  tfmname                = var.tfmname
  rgglobal               = module.ResourceGroups.rgglobalname
  endpoint_loc1          = var.location1
  endpoint_loc2          = var.location2
  target1                = module.ApplicationGateway1.pubip1id
  target2                = module.ApplicationGateway2.pubip2id
  tag_owner              = var.owner
  tag_environment        = var.environment
  tag_businessunit       = var.businessunit
  tag_application        = var.application

}