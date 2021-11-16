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

variable "rgname" {
  default = "test_cmprgwebapp"
}

variable "location" {
  default = "West US"
}

variable "tfmname" {
  default = "cmptrafficmgrvisionet"
}

variable "routingmethod" {
  default = "Weighted"
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
  default     = "Retail"
}