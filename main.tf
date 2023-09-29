resource "kubernetes_namespace" "nexus_namespace" {
  metadata {
    name = var.namespace

    labels = {
      istio-injection = "enabled"
    }

    annotations = {
      istio-injection = "enabled"
    }
  }
}

resource "helm_release" "nexus" {

  name = "nxrm"

  repository = "https://sonatype.github.io/helm3-charts/"
  chart      = "nexus-repository-manager"
  namespace  = kubernetes_namespace.nexus_namespace.metadata[0].name
  version    = var.chart_version


  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nexus_namespace
  ]

  timeout = 600

}


resource "null_resource" "nexus_password_to_secret" {
  # only run when we first create a nexus release
  triggers = {
    nexus_id = helm_release.nexus.id
  }

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    command = "${path.module}/change_nexus_password.sh ${var.nexus_admin_password} ${var.circleci_region}"
  }

  depends_on = [helm_release.nexus]
}




