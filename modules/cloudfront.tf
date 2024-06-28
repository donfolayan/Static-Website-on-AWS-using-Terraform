resource "aws_cloudfront_distribution" "donfolayan_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.donfolayan_bucket.website_endpoint
    origin_id   = var.bucket-name

    custom_origin_config {
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      http_port                = 80
      https_port               = 443
    }
  }

  custom_error_response {
    error_code = 404
    response_code = 404
    response_page_path = "/error.html"
  }

  aliases = [ var.domain-name ]

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.donfolayan_bucket.bucket

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.donfolayan_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}