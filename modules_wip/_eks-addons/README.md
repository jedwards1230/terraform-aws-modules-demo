# Elastic Kubernetes Service (EKS) Addons Module

AWS - Elastic Kubernetes Service (EKS) cluster addons (e.g. autoscaler, metrics-server, etc.)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaler_version"></a> [cluster\_autoscaler\_version](#input\_cluster\_autoscaler\_version) | value for the cluster autoscaler version | `string` | `"9.5.0"` | no |
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | value for the eks cluster name | `string` | `"eks-cluster"` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | value for the enable cluster autoscaler | `bool` | `true` | no |
| <a name="input_openid_provider_arn"></a> [openid\_provider\_arn](#input\_openid\_provider\_arn) | value for the openid provider arn | `string` | n/a | yes |

## Outputs

No outputs.