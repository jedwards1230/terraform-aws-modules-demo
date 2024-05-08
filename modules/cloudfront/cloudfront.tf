resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  # aliases         = var.domain_names # requires ACM certificate
  tags = {
    awsApplication = var.deployment_name
  }

  origin {
    domain_name = var.target_dns_name
    origin_id   = var.target_dns_name

    custom_origin_config {
      http_port              = var.origin_config.http_port
      https_port             = var.origin_config.https_port
      origin_protocol_policy = var.origin_config.origin_protocol_policy
      origin_ssl_protocols   = split(",", var.origin_config.origin_ssl_protocols)
    }
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.target_dns_name
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = true
      headers      = ["Authorization", "Host", "Origin", "Referer", "X-Forwarded-Proto"]

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    # https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements
    # CN = China
    # PA = Panama
    # RU = Russia
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "PA", "RU"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


