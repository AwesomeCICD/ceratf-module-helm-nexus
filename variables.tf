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
  default     = "64.0.0" #latest as of 2024/01/19
}


variable "circleci_region" {
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