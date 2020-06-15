variable "domain_name" {}
variable "bucket_name" {}
variable "acm_cert_arn" {}
variable "s3_www_website_endpoint" {}
variable "s3_bucket_regional_domain_name" {}
variable "aws_acm_certificate_validation" {}
variable "dependencies" {
    type = "list"
}
