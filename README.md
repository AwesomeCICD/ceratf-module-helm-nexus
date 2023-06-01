# ceratf-module-helm-nexus

Terraform module using Helm to deploy Nexus.

Relies on AWS credentials to retrieve a token for interacting with an EKS cluster. This means that you must have already assumed an AWS role with access to the cluster before you can successfully deploy this Helm chart.

## What is Nexus
 Nexus by Sonatype is a repository manager that organizes, stores and distributes artifacts needed for development. With Nexus, developers can completely control access to, and deployment of, every artifact in an organization from a single location, making it easier to distribute software.

## Requirements

- Terraform
- helm

## How to Use

1. Drop the [example module declaration](#example-usage) shown below into a Terraform plan and fill in the variables as necessary.
2. Run the Terraform plan.


## Terraform Variables

#### Optional

| Name | Default | Description|
|------|---------|------------|
|config_path| `~/.kube/config` | Path to kubecl config. |
|namespace| `default` | Namespace to deploy the container-agent to. |
|values | `.` | Values.yaml file for helm deployment of Container Runner. Resource Class Token will go here|
|chart_version| "" | Specify the exact chart version to install. If this is not specified, the latest version is installed |
|cluster_name| "" | Specify the exact cluster_name to deploy the chart version to |
|cluster_endpoint| "" | Specify the exact cluster endpoint version to deploy the chart to |
|cluster_ca_certificate| "" | Specify the cluster_ca_certificate version to install. EKS normally /etc/kubernetes/pki |

### Example usage

```hcl
module "nexus" {
  source = "github.com/AwesomeCICD/ceratf-module-helm-nexus"

  values                       = "~/path/to/values/file"
  namespace                    = "container-runner"
  config_path                  = "~/path/to/kube/config"
  cluster_name                 = "~/path/to/kube/config"
  cluster_ca_certificate       = "/etc/kubernetes/pki"
  cluster_endpoint             = "https://BBB6A4755358F411DCF363ED7381058D.gr7.eu-west-1.eks.amazonaws.com"
  
}
```