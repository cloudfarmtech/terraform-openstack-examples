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
  description = "Prefix for network, router, VM, database, and security group names"
  type        = string
  default     = "tf-lesson-databases"
}

variable "external_network_name" {
  description = "Provider external/public network name (router default gateway and floating IP pool)"
  type        = string
}

variable "private_cidr" {
  description = "IPv4 CIDR for the private subnet (VM and database attach here)"
  type        = string
  default     = "192.168.44.0/24"
}

variable "dns_nameservers" {
  description = "Optional DNS servers for the private subnet"
  type        = list(string)
  default     = []
}

variable "keypair_name" {
  description = "Name of the Nova keypair"
  type        = string
  default     = "tf-lesson-db-key"
}

variable "public_key_path" {
  description = "Path to your SSH public key on the machine running Terraform. ~ is expanded."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "public_key" {
  description = "SSH public key string. If set, public_key_path is ignored."
  type        = string
  default     = null
  sensitive   = true
}

variable "vm_image_name" {
  description = "Glance image name for the Ubuntu VM (must exist in your project or be shared/public)"
  type        = string
  default     = "Ubuntu Noble Numbat x86_64"
}

variable "vm_flavor_name" {
  description = "Nova flavor for the Ubuntu VM"
  type        = string
  default     = "g.1vcpu.4gb"
}

variable "vm_boot_volume_size_gb" {
  description = "Cinder boot volume size in GB for the VM"
  type        = number
  default     = 20
}

variable "vm_volume_type" {
  description = "Cinder volume type for the VM boot volume (set if your cloud requires it)"
  type        = string
  default     = null
}

variable "db_flavor_name" {
  description = "Flavor for the Trove database instance (Nova flavor name)"
  type        = string
  default     = "p.4vcpu.8gb"
}

variable "db_volume_size_gb" {
  description = "Cinder volume size in GB for the database data volume (Trove)"
  type        = number
  default     = 20
}

variable "db_volume_type" {
  description = "Cinder volume type for the database (required together with db_volume_size_gb by the provider)"
  type        = string
}

variable "mysql_instance_name" {
  description = "Name of the MySQL Trove instance"
  type        = string
  default     = "tf-lesson-mysql"
}

variable "mysql_datastore_version" {
  description = "Trove datastore version for the MySQL instance"
  type        = string
  default     = "8.4"
}

variable "mariadb_instance_name" {
  description = "Name of the MariaDB Trove instance"
  type        = string
  default     = "tf-lesson-mariadb"
}

variable "mariadb_datastore_version" {
  description = "Trove datastore version for the MariaDB instance"
  type        = string
  default     = "11.4"
}

variable "postgresql_instance_name" {
  description = "Name of the PostgreSQL Trove instance"
  type        = string
  default     = "tf-lesson-postgresql"
}

variable "postgresql_datastore_version" {
  description = "Trove datastore version for the PostgreSQL instance"
  type        = string
  default     = "18"
}

variable "db_test_database_name" {
  description = "Logical database (schema) created on the Trove instance"
  type        = string
  default     = "testdb"
}

variable "db_test_user_name" {
  description = "MySQL user granted access to db_test_database_name"
  type        = string
  default     = "testuser"
}

variable "db_test_user_password" {
  description = "Password for db_test_user_name (set in terraform.tfvars, never commit real values)"
  type        = string
  sensitive   = true
}

variable "db_test_user_host" {
  description = "MySQL host pattern for openstack_db_user_v1 (e.g. 192.168.50.%). Leave null to derive from private_cidr assuming /24"
  type        = string
  default     = null
}
