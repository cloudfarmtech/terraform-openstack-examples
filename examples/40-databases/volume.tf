resource "openstack_blockstorage_volume_v3" "vm_boot" {
  name        = "${var.name_prefix}-vm-boot"
  size        = var.vm_boot_volume_size_gb
  image_id    = data.openstack_images_image_v2.ubuntu.id
  volume_type = var.vm_volume_type
}
