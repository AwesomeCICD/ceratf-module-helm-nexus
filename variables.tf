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
  default     = "55.0.0" #latest as of 2023/06/09
}
