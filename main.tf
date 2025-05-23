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

resource "kubectl_manifest" "istio_virtualservice_docker" {
  force_new = true
  yaml_body = templatefile(
    "${path.module}/templates/virtualservice_docker.yaml.tpl",
    {
      namespace       = var.namespace,
      circleci_region = var.circleci_region,
      target_domain   = var.target_domain
    }
  )
  depends_on = [
    kubernetes_namespace.nexus_namespace
  ]
}
resource "kubectl_manifest" "istio_virtualservice_nexus" {
  force_new = true
  yaml_body = templatefile(
    "${path.module}/templates/virtualservice_main.yaml.tpl",
    {
      namespace       = var.namespace,
      circleci_region = var.circleci_region,
      target_domain   = var.target_domain
    }
  )
  depends_on = [
    kubernetes_namespace.nexus_namespace
  ]
}

resource "kubectl_manifest" "nexus_blob_pvc" {
  force_new = true
  yaml_body = templatefile(
    "${path.module}/templates/blob-pvc.yaml.tpl",
    {
      namespace = var.namespace,
      size      = "20Gi"
    }
  )
  depends_on = [
    kubernetes_namespace.nexus_namespace
  ]
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
    kubernetes_namespace.nexus_namespace,
    kubernetes_storage_class.expandable,
    kubectl_manifest.istio_virtualservice_nexus,
    kubectl_manifest.istio_virtualservice_docker,
    kubectl_manifest.nexus_blob_pvc
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
    command = "${path.module}/change_nexus_password.sh ${var.nexus_admin_password} ${var.target_domain}"
  }

  depends_on = [helm_release.nexus]

}


data "aws_region" "current" {}
resource "kubernetes_storage_class" "expandable" {
  metadata {
    name = "nexus-gp2"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"

  reclaim_policy = "Retain"
  allowed_topologies {
    match_label_expressions {
      key = "failure-domain.beta.kubernetes.io/zone"
      values = [
        "${data.aws_region.current.name}b"
      ]
    }
  }
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = "true"
  parameters = {
    type = "gp2"
  }
}



