variable "eks_name" {
  type        = string
  description = "value for the eks cluster name"
  default     = "eks-cluster"
}

variable "eks_version" {
  type        = string
  description = "value for the eks cluster version"
  default     = "1.29"
}

variable "subnet_ids" {
  type        = list(string)
  description = "value for the subnet ids"
}

variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes."
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

variable "node_groups" {
  type = map(object({
    capacity_type  = string
    instance_types = list(string)
    scaling_config = object({
      desired_size = number
      min_size     = number
      max_size     = number
    })
  }))
  description = "value for the node groups"
}

variable "enable_irsa" {
  type        = bool
  description = "value for the enable trsa"
  default     = true
}

variable "env" {
  type        = string
  description = "value for the environment"
}
