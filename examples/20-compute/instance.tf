resource "openstack_compute_instance_v2" "vm" {
  name            = "${var.name_prefix}-vm"
  flavor_id       = data.openstack_compute_flavor_v2.vm.id
  key_pair        = openstack_compute_keypair_v2.ssh.name
  security_groups = [openstack_networking_secgroup_v2.vm.name]

  block_device {
    uuid                  = openstack_blockstorage_volume_v3.boot.id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = openstack_networking_network_v2.private.id
  }
}

data "openstack_networking_port_v2" "vm" {
  device_id  = openstack_compute_instance_v2.vm.id
  network_id = openstack_networking_network_v2.private.id
}

resource "openstack_networking_floatingip_associate_v2" "vm" {
  floating_ip = openstack_networking_floatingip_v2.floating.address
  port_id     = data.openstack_networking_port_v2.vm.id

  depends_on = [
    openstack_compute_instance_v2.vm,
    openstack_networking_floatingip_v2.floating,
  ]
}
