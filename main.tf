resource "kubernetes_namespace" "nexus" {
  metadata {
    name        = var.namespace
    
    labels = {
      ISTIO-INJECTION = "enabled"
    }

    annotations = {
      ISTIO-INJECTION = "enabled"
    }
  }
}

resource "helm_release" "nexus" {

  name = "nxrm"

  repository = "https://sonatype.github.io/helm3-charts/"
  chart      = "nexus-repository-manager"
  namespace  = kubernetes_namespace.nexus.metadata[0].name
  version    = var.chart_version


  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nexus
  ]
}