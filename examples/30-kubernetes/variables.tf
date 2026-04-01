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

variable "cluster_name" {
  description = "Name of the Magnum Kubernetes cluster"
  type        = string
  default     = "tf-lesson-k8s"
}

variable "cluster_template_name" {
  description = "Name of an existing Magnum cluster template in your project (or public)"
  type        = string
  default     = "Kubernetes v1.34.4"
}

variable "keypair_name" {
  description = "Existing Nova keypair name for cluster nodes (SSH)"
  type        = string
}

variable "master_count" {
  description = "Number of control plane nodes"
  type        = number
  default     = 1
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 1
}

variable "create_timeout" {
  description = "Magnum cluster creation timeout in minutes"
  type        = number
  default     = 60
}

variable "flavor_name" {
  description = "Nova flavor for workers (omit to use cluster template default)"
  type        = string
  default     = null
}

variable "master_flavor_name" {
  description = "Nova flavor for masters (omit to use cluster template default)"
  type        = string
  default     = null
}

variable "floating_ip_enabled" {
  description = "Whether Magnum should allocate floating IPs for nodes (cloud/template dependent)"
  type        = bool
  default     = null
}
