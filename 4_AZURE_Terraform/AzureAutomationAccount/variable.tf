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
//------------------------AUTOMATION ACCOUNT CONFIGIRATIONS------------------------------------------

variable "rgname" {
  default = "cmprg_automationaccount"
}

variable "location" {
  default = "West US"
}
variable "AutomationAccountName" {
  default = "cmpautomationaccount"
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
  default     = "DbServer"
}