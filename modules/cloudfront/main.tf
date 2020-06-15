resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "aws_cloudfront_distribution" "www_distribution" {
  origin {
    domain_name = "${var.s3_bucket_regional_domain_name}"
    origin_id   = "${var.domain_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "${var.bucket_name}.s3.amazonaws.com"
    prefix          = "cloudfront_logs"
  }

  aliases = ["${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id       = "${var.domain_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm_cert_arn}"
    ssl_support_method = "sni-only"
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]
  
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    # List resource(s) that will be constructed last within the module.
  ]
}