output "image_id" {
  description = "Glance image ID (use for a later instance lesson)"
  value       = openstack_images_image_v2.cirros.id
}

output "image_name" {
  value = openstack_images_image_v2.cirros.name
}

output "local_image_path_resolved" {
  description = "Path used for upload"
  value       = local.image_file
}
