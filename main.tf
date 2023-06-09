resource "kubernetes_namespace" "nexus" {
  metadata {
    name        = var.namespace
    annotations = var.namespace_annotations #default enables istio injection
  }
}

resource "helm_release" "nexus" {

  name = "nxrm"

  repository = "https://sonatype.github.io/helm3-charts/"
  chart      = "nexus-repository-manager"
  namespace  = var.namespace
  version    = var.chart_version


  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nexus
  ]
}