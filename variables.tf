variable "cluster_ca_certificate" {
  description = "k8s cluster CA cert"
}

variable "cluster_endpoint" {
  description = "k8s cluster endpoint"
}

variable "cluster_name" {
  description = "k8s cluster name"
}

variable "config_path" {
  description = "path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "namespace to deploy nexus to"
  type        = string
  default     = "nexus"
}

variable "values" {
  description = "path to values.yaml file"
  type        = string
  default     = "."
}

variable "chart_version" {
  description = "helm chart version"
  type        = string
  default     = ""
}

#cacert - /etc/kubernetes/pki
#cluster-endpoint - https://BBB6A4755358F411DCF363ED7381058D.gr7.eu-west-1.eks.amazonaws.com
#cluster-name - cera-solutions-eng-emea