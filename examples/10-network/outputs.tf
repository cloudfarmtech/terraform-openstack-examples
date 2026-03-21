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

output "network_a_id" {
  description = "Internal-router: first private network ID"
  value       = openstack_networking_network_v2.a.id
}

output "subnet_a_id" {
  description = "Internal-router: first subnet ID"
  value       = openstack_networking_subnet_v2.a.id
}

output "network_b_id" {
  description = "Internal-router: second private network ID"
  value       = openstack_networking_network_v2.b.id
}

output "subnet_b_id" {
  description = "Internal-router: second subnet ID"
  value       = openstack_networking_subnet_v2.b.id
}

output "internal_router_id" {
  description = "Internal router ID (no external gateway)"
  value       = openstack_networking_router_v2.internal.id
}

output "static_route_id" {
  description = "Internal-router: extra static route ID"
  value       = openstack_networking_router_route_v2.static.id
}
