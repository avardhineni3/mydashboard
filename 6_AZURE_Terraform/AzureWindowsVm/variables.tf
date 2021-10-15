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


//--------------------------------General Properties----------------------\\
variable "rgname" {
  type    = string
  default = "RG-CMP-DEMO-WINDOWS-VM"
}
variable "vmname" {
  type    = string
  default = "cpm-demo-windows-vm"
}

variable "location" {
  type    = string
  default = "East US"
}
//-------------------------------VM Configurations--------------------------\\
variable "adminuser" {
  type    = string
  default = "vmuser"
}
variable "adminpassword" {
  type    = string
  default = ""
}
variable "vmsize" {
  type    = string
  default = "Standard_F2"
}
variable "sku" {
  type        = string
  default     = "2019-Datacenter"
  description = "Enter storage account name"
}
variable "command" {
  type    = string
  default = "apply"
}
variable "workspacekey" {
  type    = string
  default = ""
}
variable "workspaceid" {
  type    = string
  default = ""
}
//------------------------------------TAGS-------------------------------------\\
variable "owner" {
  type        = string
  default     = "Asif Bilgrami"
  description = "description"
}

variable "Environment" {
  type        = string
  default     = "Prd"
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
      id   = 1
      name   = "error"
      description = "error"
    }
  ]
}

