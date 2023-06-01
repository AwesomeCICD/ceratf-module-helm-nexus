
resource "helm_release" "nexus" {

  name = "nxrm"

  repository       = "https://sonatype.github.io/helm3-charts/"
  chart            = "nexus-repository-manager"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = true


  values = [
    file("${path.module}/values.yaml")
  ]
}