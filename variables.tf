variable "app_name" {}
variable "app_password" {}

variable "database_login" {}
variable "database_password" {}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "wordpress"
}

variable "cluster_name" {
  default = "wordpress"
}

variable "resource_group_name" {
  default = "wordpress"
}

variable "location" {
  default = "East US"
}

