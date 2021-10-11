//-------------------------------Service principal------------------------------//

variable "azure_subscription_id" {
  type        = string
  description = "description"
}

variable "azure_client_id" {
  type        = string
  description = "description"
}

variable "azure_client_secret" {
  type        = string
  description = "description"
}

variable "azure_tenant_id" {
  type        = string
  description = "description"
}

//------------------------CONFIGIRATIONS------------------------------------------//

variable "rgname1" {
  default = "test_cmprg1"
}

variable "location1" {
  default = "westeurope"
}

variable "rgname2" {
  default = "test_cmprg2"
}

variable "location2" {
  default = "northeurope"
}

variable "rgglobal" {
  default = "test_cmprgglobal"
}

variable "locationglobal" {
  default = "centralus"
}

variable "webapp1" {
  default = "cmpwebapp1"
}

variable "webapp2" {
  default = "cmpwebapp2"
}

variable "tfmname" {
  default = "visionet-cmp-tm"
}

//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Ravi"
  description = "description"
}

variable "environment" {
  type        = string
  default     = "Dev"
}

variable "businessunit" {
  type        = string
  default     = "HR"
}

variable "application" {
  type        = string
  default     = "AG"
}