# CloudFront Module

AWS - Cloudfront module (Handles Route53 and SSL certificate creation)

View an [example](../../deployments/dev/cloudfront/terragrunt.hcl)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | Deployment name (Project name + Environment) | `string` | n/a | yes |
| <a name="input_origin_config"></a> [origin\_config](#input\_origin\_config) | The origin configuration | `map(string)` | <pre>{<br>  "http_port": 80,<br>  "https_port": 443,<br>  "origin_protocol_policy": "match-viewer",<br>  "origin_ssl_protocols": "TLSv1.2"<br>}</pre> | no |
| <a name="input_target_dns_name"></a> [target\_dns\_name](#input\_target\_dns\_name) | The DNS name of the target | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain name of the CloudFront distribution |