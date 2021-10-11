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
//------------------------AG CONFIGIRATIONS------------------------------------------
variable "rgname" {
  default = "cmprg_cdn"
}

variable "location" {
  default = "West US"
}

variable "ag_name" {
  default = "cmpag"
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