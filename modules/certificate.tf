resource "aws_acm_certificate" "donfolayan_certificate" {
  domain_name = var.domain-name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}