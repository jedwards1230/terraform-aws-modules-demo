# terraform-aws-modules-demo 

This repository contains the Terraform modules and Terragrunt configurations used to manage cloud infrastructure on AWS. 

## Prerequisites

Before you get started, ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/install) (v1.8 or higher recommended).
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install) (v0.58 or higher recommended).

Development tools:
- [Terraform-docs](https://terraform-docs.io/user-guide/installation/) (v0.17 or higher recommended).

## Repository Structure

- **`/deployments`**: This directory contains Terragrunt configurations which reference the modules defined in `/modules` to deploy actual cloud resources.
- **`/modules`**: This directory contains reusable Terraform modules, each specifying a part of the AWS cloud infrastructure.
- **`/modules_wip`**: This directory contains work-in-progress Terraform modules that are not yet ready for production use. (They probably don't run as-is)
- **`/scripts`**: This directory contains scripts that can be used to automate tasks such as building Docker images and pushing them to ECR, or building documentation.
- **`/containers`**: This directory contains Dockerfiles for building Docker images that can be deployed to ECS.

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

| Provider      | Module Name       | Description                                                                                                    |
| ------------- | ----------------- | -------------------------------------------------------------------------------------------------------------- |
| hashicorp/aws | app_load_balancer | Application Load Balancer (ALB) module                                                                         |
| hashicorp/aws | cloudFront        | Cloudfront module (Handles Route53 and SSL certificate creation)                                               |
| hashicorp/aws | ecs               | Orchestrates container deployments, ensuring they're running and managing interactions with other AWS services |
| hashicorp/aws | network           | Network resources (e.g., VPC, Subnets, etc.)                                                                   |

### Work-In-Progress Modules

| Provider       | Module Name | Description                                |
| -------------- | ----------- | ------------------------------------------ |
| hashicorp/aws  | _eks        | Elastic Kubernetes Service (EKS) cluster   |
| hashicorp/helm | _eks-addons | EKS Addons module                          |
| hashicorp/aws  | _kinesis    | Kinesis stream handler                     |
| hashicorp/aws  | _route53    | Route53 domain management and DNS services |

## Development

### Build documentation

To build the documentation, run the following command from the project root directory:

```
./scripts/build_docs.sh
```

### Testing

#### ECS Deployment

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


   
