data "openstack_compute_flavor_v2" "vm" {
  name = var.flavor_name
}
