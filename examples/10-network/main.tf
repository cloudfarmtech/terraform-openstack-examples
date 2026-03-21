# Provider external (public) network used as the router default gateway for outbound/SNAT.
data "openstack_networking_network_v2" "external" {
  name = var.external_network_name
}

# Private L2 network for this lesson.
resource "openstack_networking_network_v2" "private" {
  name           = "${var.name_prefix}-net"
  admin_state_up = true
}

# IPv4 subnet on the private network (DHCP enabled by default in Neutron unless changed elsewhere).
resource "openstack_networking_subnet_v2" "private" {
  name            = "${var.name_prefix}-subnet"
  network_id      = openstack_networking_network_v2.private.id
  cidr            = var.private_cidr
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}

# Router connects the private subnet to the external network for north-south traffic.
resource "openstack_networking_router_v2" "private" {
  name                = "${var.name_prefix}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

# Attaches the private subnet to the router (L3 hop for instances on this subnet).
resource "openstack_networking_router_interface_v2" "private" {
  router_id = openstack_networking_router_v2.private.id
  subnet_id = openstack_networking_subnet_v2.private.id
}

# Allocates a floating IP from the external pool (same Neutron network name as the data source).
# Not attached to a VM port yet; a compute lesson can set port_id or use association.
resource "openstack_networking_floatingip_v2" "floating" {
  pool = var.external_network_name
}
