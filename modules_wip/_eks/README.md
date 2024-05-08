# Elastic Kubernetes Service (EKS) Module

AWS - Elastic Kubernetes Service (EKS) cluster

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.4 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | value for the eks cluster name | `string` | `"eks-cluster"` | no |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | value for the eks cluster version | `string` | `"1.29"` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | value for the enable trsa | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | value for the environment | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | value for the node groups | <pre>map(object({<br>    capacity_type  = string<br>    instance_types = list(string)<br>    scaling_config = object({<br>      desired_size = number<br>      min_size     = number<br>      max_size     = number<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_node_iam_policies"></a> [node\_iam\_policies](#input\_node\_iam\_policies) | List of IAM Policies to attach to EKS-managed nodes. | `map(any)` | <pre>{<br>  "1": "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",<br>  "2": "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",<br>  "3": "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",<br>  "4": "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | value for the subnet ids | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_name"></a> [eks\_name](#output\_eks\_name) | n/a |
| <a name="output_openid_provider_arn"></a> [openid\_provider\_arn](#output\_openid\_provider\_arn) | n/a |