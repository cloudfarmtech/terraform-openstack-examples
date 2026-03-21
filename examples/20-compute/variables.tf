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

variable "image_name" {
  description = "Name for the Glance image in your project"
  type        = string
  default     = "tf-lesson-cirros-0.6.3-x86_64"
}

variable "local_image_path" {
  description = "Absolute or module-relative path to the CirrOS disk image on your machine (qcow2)"
  type        = string
  default     = null
}
