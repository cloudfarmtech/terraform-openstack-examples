variable "auth_url" {
  description = "Keystone auth URL, for example https://openstack.example.com:5000/v3"
  type        = string
}

variable "region" {
  description = "OpenStack region name"
  type        = string
}

variable "application_credential_id" {
  description = "OpenStack Application Credential ID"
  type        = string
}

variable "application_credential_secret" {
  description = "OpenStack Application Credential secret"
  type        = string
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix for created network resources"
  type        = string
  default     = "tf-lesson-network"
}

variable "private_cidr" {
  description = "IPv4 CIDR for the private subnet"
  type        = string
  default     = "192.168.42.0/24"
}

variable "dns_nameservers" {
  description = "Optional DNS servers for the subnet"
  type        = list(string)
  default     = []
}

variable "external_network_name" {
  description = "Name of the provider external/public network used as the router default gateway"
  type        = string
}
