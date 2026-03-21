locals {
  image_file = coalesce(var.local_image_path, "${path.module}/images/cirros-0.6.3-x86_64-disk.img")
}

resource "openstack_images_image_v2" "cirros" {
  name             = var.image_name
  local_file_path  = local.image_file
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
}