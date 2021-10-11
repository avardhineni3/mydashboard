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
//------------------------General Properties------------------------------------------//
variable "lbname" {
  type    = string
  default = "cmp-lb"

}
variable "rgname" {
  type    = string
  default = "RG-CMP-LB"

}
variable "location" {
  type    = string
  default = "West US"
}
//----------------------------------------Load Balancer Configurations---------------------------//

variable "backendpools" {
  type = list(string)
  default = [
    "backendpool1", "backendpool2"
  ]
}
variable "lbrules" {
  type = list(any)
  default = [
    {
      backendport  = "3389"
      frontendport = "3389"
    },
    {
      backendport  = "80"
      frontendport = "80"
    }
  ]
}

//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Ali Arslan"
  description = "description"
}

variable "Environment" {
  type        = string
  default     = "Dev"
  description = "Enter storage account name"
}

variable "Buisness_unit" {
  type        = string
  default     = "HR"
  description = "Enter storage account name"
}

variable "Application" {
  type        = string
  default     = "DbServer"
  description = "Enter storage account name"
}






