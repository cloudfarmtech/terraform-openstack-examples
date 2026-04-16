locals {
  public_key_material = var.public_key != null ? var.public_key : file(pathexpand(var.public_key_path))
}

resource "openstack_compute_keypair_v2" "ssh" {
  name       = var.keypair_name
  public_key = local.public_key_material
}
