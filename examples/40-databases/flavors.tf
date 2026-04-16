data "openstack_compute_flavor_v2" "vm" {
  name = var.vm_flavor_name
}

data "openstack_compute_flavor_v2" "db" {
  name = var.db_flavor_name
}
