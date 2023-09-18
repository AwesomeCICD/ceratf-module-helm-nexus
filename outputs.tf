output "namespace" {
  value = helm_release.nexus.namespace
}

output "admin_password" {
  value = "Nexus is using default admin password admin123 you should change that."

}