variable "auth_url" {
  description = "Keystone auth URL"
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

# --- cluster ---

variable "cluster_name" {
  type    = string
  default = "tf-lesson-k8s-nodegroups"
}

variable "cluster_template_name" {
  type    = string
  default = "Kubernetes v1.34.4"
}

variable "keypair_name" {
  type = string
}

variable "master_count" {
  type    = number
  default = 1
}

variable "node_count" {
  type    = number
  default = 1
}

variable "master_flavor_name" {
  type    = string
  default = "m.2vcpu.16gb"
}

variable "floating_ip_enabled" {
  type    = bool
  default = true
}

variable "create_timeout" {
  type    = number
  default = 60
}

# --- nodegroup ---

variable "nodegroup_name" {
  type    = string
  default = "default"
}

variable "nodegroup_image" {
  description = "Glance image name (or UUID) for the node group"
  type        = string
  default     = "CAPI v1.34.4 x86_64"
}

variable "nodegroup_flavor" {
  description = "Nova flavor name for the node group"
  type        = string
  default     = "g.8vcpu.32gb"
}

variable "nodegroup_node_count" {
  type    = number
  default = 1
}
