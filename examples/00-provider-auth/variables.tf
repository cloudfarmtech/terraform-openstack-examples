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
