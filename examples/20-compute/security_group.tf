resource "openstack_networking_secgroup_v2" "vm" {
  name        = "${var.name_prefix}-sg"
  description = "Lesson VM: SSH from anywhere (tighten in real use)"
}

resource "openstack_networking_secgroup_rule_v2" "vm_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vm.id
}

resource "openstack_networking_secgroup_rule_v2" "vm_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.vm.id
}
