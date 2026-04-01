data "openstack_containerinfra_clustertemplate_v1" "selected" {
  name = var.cluster_template_name
}

resource "openstack_containerinfra_cluster_v1" "this" {
  name                = var.cluster_name
  cluster_template_id = data.openstack_containerinfra_clustertemplate_v1.selected.id
  keypair             = var.keypair_name
  master_count        = var.master_count
  node_count          = var.node_count
  create_timeout      = var.create_timeout

  flavor        = var.flavor_name
  master_flavor = var.master_flavor_name

  floating_ip_enabled = var.floating_ip_enabled
}
