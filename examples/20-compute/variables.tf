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

variable "keypair_name" {
  description = "Name of the Nova keypair in OpenStack"
  type        = string
  default     = "tf-lesson-key"
}

variable "public_key_path" {
  description = "Path to your SSH public key on the machine running Terraform (used when public_key is not set). ~ is expanded."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "public_key" {
  description = "SSH public key string (ssh-rsa/ed25519 ...). If set, public_key_path is ignored."
  type        = string
  default     = null
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix for network, router, VM, and security group names"
  type        = string
  default     = "tf-lesson-compute"
}

variable "external_network_name" {
  description = "Provider external/public network name (router default gateway and floating IP pool), same idea as examples/10-network"
  type        = string
}

variable "private_cidr" {
  description = "IPv4 CIDR for the private subnet"
  type        = string
  default     = "192.168.42.0/24"
}

variable "dns_nameservers" {
  description = "Optional DNS servers for the private subnet"
  type        = list(string)
  default     = []
}

variable "flavor_name" {
  description = "Nova flavor name available in your cloud (examples: m1.small, tiny)"
  type        = string
}

variable "boot_volume_size_gb" {
  description = "Cinder boot volume size in GB (must meet cloud minimum; flavors with disk 0 require a volume-backed boot)"
  type        = number
  default     = 10
}

variable "volume_type" {
  description = "Cinder volume type name (set if your cloud requires it, e.g. fast-ssd)"
  type        = string
  default     = null
}
