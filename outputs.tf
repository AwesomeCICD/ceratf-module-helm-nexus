output "namespace" {
  value = helm_release.nexus.namespace
}

output "admin_password" {
  value     = random_password.new_nexus_password.result
  sensitive = true
}