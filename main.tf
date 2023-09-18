resource "kubernetes_namespace" "nexus_namespace" {
  metadata {
    name        = var.namespace
    
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

resource "random_password" "new_nexus_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "nexus_security_user" "admin" {
  userid    = "admin"
  firstname = "Administrator"
  lastname  = "User"
  email     = "eddie@circleci.com"
  password  = random_password.new_nexus_password.result
  roles     = ["nx-admin"]
  status    = "active"
  depends_on = [ helm_release.nexus ]
}