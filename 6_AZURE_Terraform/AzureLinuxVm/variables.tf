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

//--------------------------------General Properties---------------------\\
variable "rgname" {
  type    = string
  default = "RG-CMP-DEMO-LINUX-1"
}
variable "vmname" {
  type    = string
  default = "cpm-demo-linux-vm"
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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSUGPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XAt3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/EnmZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbxNrRFi9wrf+M7Q== schacon@mylaptop.local"
}

variable "vmsize" {
  type    = string
  default = "Standard_F2"
}
variable "publisher" {
  type    = string
  default = "Canonical"
}
variable "offer" {
  type    = string
  default = "UbuntuServer"
}
variable "sku" {
  type    = string
  default = "18.04-LTS"
}
variable "command" {
  type    = string
  default = "apply"
}
variable "workspacekey" {
  type    = string
  default = "OS4PnAEOJW2+6ekDkOYh7Awja6sgCfvQKYUxvYg/XZ+ziRIpHrCxyuGIWRM2Z9sdjRThPqRmGY3RcN/BcR9y/w=="
}
variable "workspaceid" {
  type    = string
  default = "41d62148-ac40-4d9b-a790-b93c0e47c4e6"
}
//------------------------------------TAGS-------------------------\\
variable "owner" {
  type        = string
  default     = "Asif Bilgrami"
  description = "description"
}

variable "Environment" {
  type        = string
  default     = "PRD"
  description = "Enter storage account name"
}

variable "Business_unit" {
  type        = string
  default     = "Accounts-1"
  description = "Enter storage account name"
}

variable "Application" {
  type        = string
  default     = "TesDbServer1"
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

