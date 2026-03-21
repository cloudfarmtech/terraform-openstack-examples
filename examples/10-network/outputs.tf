output "network_id" {
  description = "Private network ID"
  value       = openstack_networking_network_v2.private.id
}

output "subnet_id" {
  description = "Private subnet ID"
  value       = openstack_networking_subnet_v2.private.id
}

output "router_id" {
  description = "Router ID with external gateway"
  value       = openstack_networking_router_v2.private.id
}

output "external_network_id" {
  description = "External network ID used for SNAT"
  value       = data.openstack_networking_network_v2.external.id
}

output "floating_ip_id" {
  description = "Allocated floating IP resource ID"
  value       = openstack_networking_floatingip_v2.floating.id
}

output "floating_ip_address" {
  description = "Allocated public IPv4 address"
  value       = openstack_networking_floatingip_v2.floating.address
}
