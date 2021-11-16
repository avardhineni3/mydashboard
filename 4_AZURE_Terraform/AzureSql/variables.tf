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

//--------------------------------General Properties----------------\\
variable "rgname" {
  type    = string
  default = "RG-CMP-DEMO-SQL"
}
variable "sqlservername" {
  type    = string
  default = "cpm-demo-sql"
}

variable "location" {
  type    = string
  default = "West US"
}
//-----------------------------------SQL CONFIGURATIONS-------------------\\
variable "username" {
  type    = string
  default = "adminuser"
}
variable "password" {
  type    = string
  default = "M@gento12345"
}
variable "dbname" {
  type    = string
  default = "cmpsqldemodb"
}
variable "dbsize" {
  type    = string
  default = "10"
}
variable "staccountname" {
  type    = string
  default = "cmpdemostaccount"

}
variable "firewallrules" {
  type = list(any)
  default = [
    {
      startip = "10.0.0.1"
      endip   = "10.0.0.1"
    },
    {
      startip = "10.0.0.2"
      endip   = "10.0.0.2"
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


//------------------------------------------TF Errors------------------------\\
variable "init_stderr" {
  type    = string
  default = "error"
}
variable "init_stdout" {
  type    = string
  default = "error"
}
variable "stderr" {
  type    = string
  default = "error"
}
variable "stdout" {
  type = list(any)
  default = [
    {
      id          = 1
      name        = "error"
      description = "error"
    }
  ]
}

