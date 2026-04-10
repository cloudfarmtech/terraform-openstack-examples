data "openstack_containerinfra_clustertemplate_v1" "this" {
  name = var.cluster_template_name
}

resource "openstack_containerinfra_cluster_v1" "this" {
  name                = var.cluster_name
  cluster_template_id = data.openstack_containerinfra_clustertemplate_v1.this.id
  keypair             = var.keypair_name
  master_count        = var.master_count
  node_count          = var.node_count
  create_timeout      = var.create_timeout
  master_flavor       = var.master_flavor_name
  floating_ip_enabled = var.floating_ip_enabled
}

resource "openstack_containerinfra_nodegroup_v1" "batch_worker" {
  name       = var.nodegroup_name
  cluster_id = openstack_containerinfra_cluster_v1.this.id
  image_id   = var.nodegroup_image
  flavor_id  = var.nodegroup_flavor
  node_count = var.nodegroup_node_count
}
