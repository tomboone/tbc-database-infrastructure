variable "existing_rg_name" {
  type = string
  description = "Name of existing resource group to use"
}

variable "existing_private_endpoints_subnet_name" {
  type = string
  description = "Name of existing private endpoints subnet to use"
}

variable "existing_private_endpoints_subnet_rg_name" {
  type = string
  description = "Resource group name of the existing private endpoints subnet"
}

variable "existing_private_endpoints_subnet_vnet_name" {
  type = string
  description = "Virtual network name of the existing private endpoints subnet"
}

variable "mysql_administrator_login" {
  type = string
  description = "Admin user name for MySQL server"
  sensitive = true
}

variable "mysql_administrator_password" {
  type = string
  description = "Admin user password for MySQL server"
  sensitive = true
}

variable "identity_id" {
  type = string
  description = "User assigned identity resource ID"
  sensitive = true
}