output "network_id" {
  description = "Private network ID (VM and database)"
  value       = openstack_networking_network_v2.private.id
}

output "subnet_id" {
  description = "Private subnet ID"
  value       = openstack_networking_subnet_v2.private.id
}

output "router_id" {
  description = "Router with external gateway (SNAT to the internet for the private subnet)"
  value       = openstack_networking_router_v2.private.id
}

output "vm_instance_id" {
  description = "Nova instance UUID"
  value       = openstack_compute_instance_v2.vm.id
}

output "vm_private_ipv4" {
  description = "Fixed IPv4 of the VM on the private subnet"
  value       = openstack_compute_instance_v2.vm.network[0].fixed_ip_v4
}

output "vm_floating_ip" {
  description = "Floating IPv4 for SSH to the VM"
  value       = openstack_networking_floatingip_v2.floating.address
}

output "mysql_instance_id" {
  description = "Trove MySQL instance ID"
  value       = openstack_db_instance_v1.mysql.id
}

output "mysql_addresses" {
  description = "IP addresses reported by Trove for the MySQL instance"
  value       = openstack_db_instance_v1.mysql.addresses
}

output "mariadb_instance_id" {
  description = "Trove MariaDB instance ID"
  value       = openstack_db_instance_v1.mariadb.id
}

output "mariadb_addresses" {
  description = "IP addresses reported by Trove for the MariaDB instance"
  value       = openstack_db_instance_v1.mariadb.addresses
}

output "postgresql_instance_id" {
  description = "Trove PostgreSQL instance ID"
  value       = openstack_db_instance_v1.postgresql.id
}

output "postgresql_addresses" {
  description = "IP addresses reported by Trove for the PostgreSQL instance"
  value       = openstack_db_instance_v1.postgresql.addresses
}

output "db_test_database_name" {
  description = "Name of the logical database created on each Trove instance"
  value       = var.db_test_database_name
}

output "db_test_user_name" {
  description = "User granted access to the test database on each Trove instance"
  value       = var.db_test_user_name
}

output "db_test_user_host" {
  description = "MySQL/MariaDB host pattern used for openstack_db_user_v1 (derived from private_cidr assuming /24 when db_test_user_host is unset; ignored by PostgreSQL)"
  value       = local.db_test_user_host
}

