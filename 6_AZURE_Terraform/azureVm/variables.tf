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
  default = "RG-CMP-DEMO-LINUXVM"
}
variable "vmname" {
  type    = string
  default = "cpm-demo-vm"
}

variable "location" {
  type    = string
  default = "West US"
}
//-------------------------------VM Configurations--------------------------\\
variable "adminuser" {
  type    = string
  default = "vmuser"
}
variable "adminpassword" {
  type    = string
  default = "M@gento12345"
}
variable "vmsize" {
  type    = string
  default = "Standard_F2"
}

//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Asif Bilgrami"
  description = "description"
}

variable "Enviorment" {
  type        = string
  default     = "PRD"
  description = "Enter storage account name"
}

variable "Buisness_unit" {
  type        = string
  default     = "Accounts"
  description = "Enter storage account name"
}

variable "Application" {
  type        = string
  default     = "AccountsDbServer"
  description = "Enter storage account name"
}

variable "Platform" {
  type        = string
  default     = "Linux"
  description = "Enter storage account name"
}

variable "Type" {
  type        = string
  default     = "Node Exporter"
  description = "Enter storage account name"
}

