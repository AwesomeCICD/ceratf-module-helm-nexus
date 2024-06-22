variable "namespace" {
  description = "namespace to deploy nexus to"
  type        = string
  default     = "nexus"
}

variable "namespace_annotations" {
  description = "namespace to deploy nexus to"
  type        = map(string)
  default = {
    "istio-injection" = "enabled"
  }
}

variable "values" {
  description = "path to values.yaml file"
  type        = string
  default     = "."
}

variable "chart_version" {
  description = "helm chart version"
  type        = string
  default     = "64.2.0" #latest as of 2024/06/21
}


variable "circleci_region" {
  description = "where we at"
  type        = string
}

variable "target_domain" {
  description = "where we at"
  type        = string
}

variable "nexus_admin_password" {
  description = "the target password for nexus admin"
  type        = string
  sensitive   = true
}

variable "vault_mount_path" {
  type    = string
  default = "secret"
}