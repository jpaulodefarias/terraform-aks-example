variable "app_name" {
  default = "f15c6d88-13f3-42bf-a180-267da96dab74"
}
variable "app_password" {
  default = "WeO8Q~14zHe8bHr0Ay3MyhQcdl37ITSWd0~iDaeQ"
}

variable "database_login" {
  default = "wordpress"
}
variable "database_password" {
  default = "7CyiEs!NsStNYk5G"
}

variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "/ssh/akspublickey.pub"
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
  default = "westeurope"
}

variable "acr_name" {
  default = "containerregistrywordpress"
}

variable "managed_identity_name" {
  default = "wordpress-identity"
}
variable "subscriptionId" {
  default = "0a3905c6-df2d-41a0-8709-31cda42c661f"
}
variable "clientID" {
  default = "f15c6d88-13f3-42bf-a180-267da96dab74"
}
variable "clientSecret" {
  default = "WeO8Q~14zHe8bHr0Ay3MyhQcdl37ITSWd0~iDaeQ"
}
variable "tenantID" {
  default = "76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61"
}