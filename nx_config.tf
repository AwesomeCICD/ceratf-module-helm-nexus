

resource "random_password" "deployer_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "nexus_repository_docker_hosted" "cera_hosted" {
  name   = "cera-hosted"
  online = true

  docker {
    force_basic_auth = false
    v1_enabled       = false
    http_port        = 8443
  }

  storage {
    blob_store_name                = "cera-hosted"
    strict_content_type_validation = true
    write_policy                   = "ALLOW"
  }

  # cleanup {
  #   policy_names = []
  # }

}

resource "nexus_repository_helm_hosted" "cera_helm" {
  name   = "cera-helm"
  online = true

  storage {
    blob_store_name                = "cera-helm"
    strict_content_type_validation = false
    write_policy                   = "ALLOW"
  }
}

resource "nexus_security_role" "cera_deploy" {
  description = "Docker deployment role"
  name        = "CERA Deployer"
  privileges = [
    "nx-repository-admin-docker-cera-hosted-*",
    "nx-repository-admin-helm-cera-helm-*"
  ]
  roleid     = "cera-deployer"
  depends_on = [nexus_repository_docker_hosted.cera_hosted, nexus_repository_helm_hosted.cera_helm]
}

resource "nexus_security_user" "cera_deployer" {
  userid    = "cera-deployer"
  firstname = "CERA"
  lastname  = "Deployer"
  email     = "eddie@circleci.com"
  password  = random_password.deployer_password.result
  roles     = [nexus_security_role.cera_deploy.roleid]
  status    = "active"

  depends_on = [nexus_security_role.cera_deploy]
}