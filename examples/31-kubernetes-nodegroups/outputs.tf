output "cluster_id" {
  value = openstack_containerinfra_cluster_v1.this.id
}

output "cluster_name" {
  value = openstack_containerinfra_cluster_v1.this.name
}

output "api_address" {
  value = openstack_containerinfra_cluster_v1.this.api_address
}

output "coe_version" {
  value = openstack_containerinfra_cluster_v1.this.coe_version
}

output "master_addresses" {
  value = openstack_containerinfra_cluster_v1.this.master_addresses
}

output "node_addresses" {
  value = openstack_containerinfra_cluster_v1.this.node_addresses
}

output "nodegroup_id" {
  value = openstack_containerinfra_nodegroup_v1.batch_worker.id
}

output "kubeconfig_raw" {
  value     = openstack_containerinfra_cluster_v1.this.kubeconfig["raw_config"]
  sensitive = true
}
