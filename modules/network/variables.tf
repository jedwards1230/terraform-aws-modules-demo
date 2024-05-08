variable "env" {
  type        = string
  description = "value for the environment"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "value for the vpc cidr block"
}

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
  description = "value for the private subnets CIDR blocks"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
  description = "value for the public subnets CIDR blocks"
}

variable "private_subnet_tags" {
  type = map(any)
  default = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }
  description = "value for the private subnets tags"
}

variable "public_subnet_tags" {
  type = map(any)
  default = {
    "kubernetes.io/role/elb"         = "1"
    "kubernetes.io/cluster/dev-demo" = "owned"
  }
  description = "value for the public subnets tags"
}

variable "subnet_availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "value for the subnet availability zones"
}


