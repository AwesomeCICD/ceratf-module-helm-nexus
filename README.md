# ceratf-module-helm-nexus

Terraform module using Helm to deploy Nexus.

Relies on AWS credentials to retrieve a token for interacting with an EKS cluster. This means that you must have already assumed an AWS role with access to the cluster before you can successfully deploy this Helm chart.

## What is Nexus
 Nexus by Sonatype is a repository manager that organizes, stores and distributes artifacts needed for development. With Nexus, developers can completely control access to, and deployment of, every artifact in an organization from a single location, making it easier to distribute software.

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >=1.14.0 |
| <a name="requirement_nexus"></a> [nexus](#requirement\_nexus) | >=1.21.2 |
## Usage
Basic usage of this module is as follows:
```hcl
module "nexus" {
	source  = "git@github.com:AwesomeCICD/ceratf-module-helm-nexus?ref=1.0.0"

	depends_on = [module.vault_config]
}
```
## Resources

| Name | Type |
|------|------|
| [helm_release.nexus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.nexus_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [nexus_repository_docker_hosted.cera_hosted](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/repository_docker_hosted) | resource |
| [nexus_repository_helm_hosted.cera_helm](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/repository_helm_hosted) | resource |
| [nexus_security_anonymous.system](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/security_anonymous) | resource |
| [nexus_security_realms.example](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/security_realms) | resource |
| [nexus_security_role.cera_deploy](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/security_role) | resource |
| [nexus_security_user.cera_deployer](https://registry.terraform.io/providers/datadrivers/nexus/latest/docs/resources/security_user) | resource |
| [random_password.deployer_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_kv_secret_v2.cera_deployer](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | helm chart version | `string` | `"55.0.0"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | namespace to deploy nexus to | `string` | `"nexus"` | no |
| <a name="input_namespace_annotations"></a> [namespace\_annotations](#input\_namespace\_annotations) | namespace to deploy nexus to | `map(string)` | <pre>{<br>  "istio-injection": "enabled"<br>}</pre> | no |
| <a name="input_values"></a> [values](#input\_values) | path to values.yaml file | `string` | `"."` | no |
| <a name="input_vault_mount_path"></a> [vault\_mount\_path](#input\_vault\_mount\_path) | n/a | `string` | `"secret"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | n/a |
| <a name="output_deployer_password"></a> [deployer\_password](#output\_deployer\_password) | n/a |
| <a name="output_deployer_username"></a> [deployer\_username](#output\_deployer\_username) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->