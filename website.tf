module "website" {
  source      = "./modules"
  bucket-name = var.bucket-name
  domain-name = var.domain-name
}