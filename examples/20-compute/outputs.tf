output "image_id" {
  description = "Glance image ID"
  value       = openstack_images_image_v2.cirros.id
}

output "image_name" {
  value = openstack_images_image_v2.cirros.name
}

output "local_image_path_resolved" {
  description = "Path used for image upload"
  value       = local.image_file
}

output "keypair_name" {
  description = "Nova keypair name"
  value       = openstack_compute_keypair_v2.ssh.name
}

output "keypair_fingerprint" {
  value = openstack_compute_keypair_v2.ssh.fingerprint
}

output "network_id" {
  description = "Private network ID"
  value       = openstack_networking_network_v2.private.id
}

output "subnet_id" {
  description = "Private subnet ID"
  value       = openstack_networking_subnet_v2.private.id
}

output "router_id" {
  description = "Router with external gateway"
  value       = openstack_networking_router_v2.private.id
}

output "external_network_id" {
  description = "External network ID (from data source)"
  value       = data.openstack_networking_network_v2.external.id
}

output "floating_ip_id" {
  value = openstack_networking_floatingip_v2.floating.id
}

output "boot_volume_id" {
  description = "Cinder boot volume ID"
  value       = openstack_blockstorage_volume_v3.boot.id
}

output "instance_id" {
  description = "Nova instance UUID"
  value       = openstack_compute_instance_v2.vm.id
}

output "private_ipv4" {
  description = "Fixed IPv4 on the private subnet"
  value       = openstack_compute_instance_v2.vm.network[0].fixed_ip_v4
}

output "floating_ip_address" {
  description = "Public IPv4 associated to the instance"
  value       = openstack_networking_floatingip_v2.floating.address
}
