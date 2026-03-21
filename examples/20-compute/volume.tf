resource "openstack_blockstorage_volume_v3" "boot" {
  name        = "${var.name_prefix}-boot"
  size        = var.boot_volume_size_gb
  image_id    = openstack_images_image_v2.cirros.id
  volume_type = var.volume_type
}
