variable "deployment_name" {
  description = "Deployment name (Project name + Environment)"
  type        = string
}

variable "target_dns_name" {
  description = "The DNS name of the target"
  type        = string
}

variable "origin_config" {
  description = "The origin configuration"
  type        = map(string)
  default = {
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "match-viewer"
    origin_ssl_protocols   = "TLSv1.2"
  }
}
