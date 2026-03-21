# Second scenario: internal-only router (no external gateway), two subnets, static route.

# First isolated L2 network (net-a).
resource "openstack_networking_network_v2" "a" {
  name           = "${var.name_prefix}-net-a"
  admin_state_up = true
}

# IPv4 subnet on net-a (private_cidr_a).
resource "openstack_networking_subnet_v2" "a" {
  name            = "${var.name_prefix}-subnet-a"
  network_id      = openstack_networking_network_v2.a.id
  cidr            = var.private_cidr_a
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

# Second isolated L2 network (net-b).
resource "openstack_networking_network_v2" "b" {
  name           = "${var.name_prefix}-net-b"
  admin_state_up = true
}

# IPv4 subnet on net-b (private_cidr_b).
resource "openstack_networking_subnet_v2" "b" {
  name            = "${var.name_prefix}-subnet-b"
  network_id      = openstack_networking_network_v2.b.id
  cidr            = var.private_cidr_b
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

# No external_network_id: only east-west between attached subnets; no SNAT to provider public net.
resource "openstack_networking_router_v2" "internal" {
  name           = "${var.name_prefix}-internal-router"
  admin_state_up = true
}

# Connect subnet A to the internal router.
resource "openstack_networking_router_interface_v2" "a" {
  router_id = openstack_networking_router_v2.internal.id
  subnet_id = openstack_networking_subnet_v2.a.id
}

# Connect subnet B to the same router (enables forwarding between the two CIDRs).
resource "openstack_networking_router_interface_v2" "b" {
  router_id = openstack_networking_router_v2.internal.id
  subnet_id = openstack_networking_subnet_v2.b.id
}

# Extra route: traffic to static_route_destination_cidr via next_hop (must be an IP on subnet a or b).
resource "openstack_networking_router_route_v2" "static" {
  router_id        = openstack_networking_router_v2.internal.id
  destination_cidr = var.static_route_destination_cidr
  next_hop         = var.static_route_next_hop

  depends_on = [
    openstack_networking_router_interface_v2.a,
    openstack_networking_router_interface_v2.b,
  ]
}
