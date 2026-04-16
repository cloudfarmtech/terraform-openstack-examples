data "openstack_images_image_v2" "ubuntu" {
  name        = var.vm_image_name
  most_recent = true
}
