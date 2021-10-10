variable azure_subscription_id {
  type        = string
  default     = ""
  description = "description"
}

variable azure_client_id {
  type        = string
  default     = ""
  description = "description"
}

variable azure_client_secret {
  type        = string
  default     = ""
  description = "description"
}

variable azure_tenant_id {
  type        = string
  default     = ""
  description = "description"
}

variable resource_group_name {
  type        = string
  default     = "RG-CMP-VMs"
  description = "Enter Azure Resource group name"
}

variable location {
  type        = string
  default     = "East US 2"
  description = "Enter region"
}

variable storage_account {
  type        = string
  default     = "cmpstoracc"
  description = "Enter storage account name"
}


