resource "local_sensitive_file" "kubeconfig" {
  filename = "${path.module}/.kubeconfig"
  content  = openstack_containerinfra_cluster_v1.this.kubeconfig["raw_config"]
}

resource "null_resource" "taint_batch_workers" {
  triggers = {
    taint_key    = "workload"
    taint_value  = "batch"
    taint_effect = "NoSchedule"
    selector     = "capi.stackhpc.com/node-group=batch-worker"
    kubeconfig   = "${path.module}/.kubeconfig"
  }

  provisioner "local-exec" {
    command = <<-EOT
      KUBECONFIG=${self.triggers.kubeconfig} \
      kubectl taint nodes -l ${self.triggers.selector} \
      ${self.triggers.taint_key}=${self.triggers.taint_value}:${self.triggers.taint_effect} --overwrite
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
      KUBECONFIG=${self.triggers.kubeconfig} \
      kubectl taint nodes -l ${self.triggers.selector} \
      ${self.triggers.taint_key}:${self.triggers.taint_effect}-
    EOT
  }

  depends_on = [local_sensitive_file.kubeconfig]
}