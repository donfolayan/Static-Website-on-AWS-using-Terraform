variable "domain-name" {
  description = "The name of the domain to use for the website"
  type        = string
}

variable "bucket-name" {
  description = "The name of the S3 bucket used to store the website files"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the website to"
  type        = string
  default     = "us-east-1"
}
