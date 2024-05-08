# Terranut

This repository contains the Terraform modules and Terragrunt configurations used to manage cloud infrastructure on AWS. 

## Prerequisites

Before you get started, ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/install) (v1.8 or higher recommended).
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install) (v0.58 or higher recommended).

## Repository Structure

- **`/modules`**: This directory contains reusable Terraform modules, each specifying a part of the AWS cloud infrastructure.
- **`/deployments`**: This directory contains Terragrunt configurations which reference the modules defined in `/modules` to deploy actual cloud resources.

## Using Terragrunt

Terragrunt is a thin wrapper that provides extra tools for keeping your Terraform configurations DRY, working with multiple Terraform modules, and managing remote state. To use Terragrunt with the configurations in this repo:

1. Navigate to a specific environment configuration under the `./deployments` directory.

   ```
   cd deployments/<environment>
   ```
2. Initialize the Terragrunt configuration:

   ```
   terragrunt run-all init
   ```
3. Apply the Terragrunt configuration:

   ```
   terragrunt run-all apply
   ```

## Modules Catalog

Terragrunt has a tool that lets you easily browse and scaffold modules in this repository. To use this tool, run the following command from the root of the repository:

```
terragrunt catalog
```

### Available Modules

| Provider | Module Name            | Description                                              |
|----------|------------------------|----------------------------------------------------------|
| AWS      | Kinesis                | Kinesis stream handler                                   |
| AWS      | Application Load Balancer | Application Load Balancer (ALB) module                |
| AWS      | CloudFront             | Cloudfront module (Handles Route53 and SSL certificate creation) |
| AWS      | Elastic Container Service (ECS) | Orchestrates container deployments, ensuring they're running and managing interactions with other AWS services |
| AWS      | Elastic Kubernetes Service (EKS) | Elastic Kubernetes Service (EKS) cluster            |
| AWS      | Network                | Network resources (e.g., VPC, Subnets, etc.)             |
| AWS      | Route53                | Route53 domain management and DNS services               |


## Development

### Testing

This demo deploys a docker image to an ECS cluster. To test the deployment, run the following commands:

1. Retrieve the Authentication Token and Authenticate Docker to ECR:

   ```
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
   ```

2. Navigate to the demo image directory:

   ```
   cd containers/demo
   ```

3. Build the Docker image:

   ```
   npm run build:docker
   ```

4. Push the Docker image to ECR:

   ```
   npm run push:docker (TODO)
   ```


   