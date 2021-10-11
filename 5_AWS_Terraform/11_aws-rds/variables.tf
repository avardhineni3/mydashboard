variable size {
  type        = string
  default     = "40"
  description = "ebs size"
}

variable location {
  type        = string
  default     = "us-east-1"
  description = "Enter region"
}

variable db_name {
  type        = string
  default     = "CMP-Test"
  description = "description"
}
variable db_identifier {
  type        = string
  default     = "cmpterra"
  description = "description"
}

variable db_engine {
  type        = string
  default     = "mysql"
  description = "entern engine name"
}

variable db_engine_version {
  type        = string
  default     = "5.7"
  description = "enter engine version"
}

variable db_instance_class {
  type        = string
  default     = "db.t3.micro"
  description = "select instance class"
}

variable db_username {
  type        = string
  default     = "foo"
  description = "enter username "

}

variable db_multi_az {
  type        = bool
  default     = false
  description = "description"
}

variable access_key {
  type        = string
  default     = ""
  description = "Enter access "
}

variable secret_key {
  type        = string
  default     = ""
  description = "Enter secret key "
}

variable owner {
  type        = string
  default     = "Asif Bilgrami"
  description = "description"
}

variable Enviorment {
  type        = string
  default     = "PRD"
  description = "Enter storage account name"
}
