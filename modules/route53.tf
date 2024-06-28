resource "aws_route53_zone" "donfolayan_hosted_zone" {
  name = var.domain-name
}

resource "aws_route53_record" "donfolayan_record" {
    for_each = {
        for record in aws_acm_certificate.donfolayan_certificate.domain_validation_options : record.domain_name => {
            name    = record.resource_record_name
            record  = record.resource_record_value
            type    = record.resource_record_type
        }
    }

    zone_id = aws_route53_zone.donfolayan_hosted_zone.zone_id
    name    = each.value.name
    type    = each.value.type
    ttl = 60
    allow_overwrite = true
    records = [each.value.record]
}

resource "aws_route53_record" "donfolayan_dns_record" {
  zone_id = aws_route53_zone.donfolayan_hosted_zone.zone_id
  name    = var.domain-name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.donfolayan_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.donfolayan_distribution.hosted_zone_id
    evaluate_target_health = false
  }
  
}