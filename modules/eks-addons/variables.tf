variable "openid_provider_arn" {
  type        = string
  description = "value for the openid provider arn"
}

variable "enable_cluster_autoscaler" {
  type        = bool
  description = "value for the enable cluster autoscaler"
  default     = true
}

variable "eks_name" {
  type        = string
  description = "value for the eks cluster name"
  default     = "eks-cluster"
}

variable "cluster_autoscaler_version" {
  type        = string
  description = "value for the cluster autoscaler version"
  default     = "9.5.0"
}
