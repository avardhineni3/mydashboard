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

variable "rgname" {
  type    = string
  default = "RG-CMP-ST"

}
variable "location" {
  type    = string
  default = "East US"
}
variable "command" {
  type    = string
  default = "Apply"
}
//---------------------------ST CONFIGURATIONS------------------------------//
variable "stname" {
  type    = string
  default = "cmpstorageaccountdemo"
}
variable "account_tier" {
  type    = string
  default = "Standard"
}
variable "account_replication_type" {
  type    = string
  default = "LRS"
}
variable "container_name" {
  type    = string
  default = "democont"
}
variable "blobname" {
  type    = string
  default = "demoblob"
}
variable "blobtype" {
  type    = string
  default = "Block"
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



