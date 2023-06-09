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
|namespace| `nexus` | Namespace to deploy nexus to. |
|values | `.` | Values.yaml file for helm deployment of Nexus.|
|chart_version| "55.0.0" | Specify the exact chart version to install. If this is not specified, the latest version is installed |

### Example usage

```hcl
module "nexus" {
  source = "git@github.com:AwesomeCICD/ceratf-module-helm-nexus"

  # Optional
  #values                       = "~/path/to/values/file"
  #namespace                    = "nexus" #default
  #chart_version                = "55.0.0"
 
}
```