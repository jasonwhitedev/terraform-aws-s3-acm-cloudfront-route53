provider "aws" {
  region = "${var.aws_region}"
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "${var.bucket_name}"

  dependencies = [
    "${module.s3.depended_on}",
  ]

}

module "acm" {
  source = "./modules/acm"
  domain_name = "${var.domain_name}"
  hosted_zone = "${var.hosted_zone}"

  dependencies = [
    "${module.s3.depended_on}",
  ]
}

module "cloudfront" {
  source = "./modules/cloudfront"
  domain_name = "${var.domain_name}"
  bucket_name = "${var.bucket_name}"
  s3_www_website_endpoint = "${module.s3.s3_www_website_endpoint}"
  acm_cert_arn = "${module.acm.certificate_arn}"
  s3_bucket_regional_domain_name = "${module.s3.s3_bucket_regional_domain_name}"
  aws_acm_certificate_validation = "${module.acm.certificate_validation}"

  dependencies = [
    "${module.acm.depended_on}",
  ]

}

module "route53" {
  source = "./modules/route53"
  domain_name = "${var.domain_name}"
  hosted_zone = "${var.hosted_zone}"
  cloudfront_domain_name = "${module.cloudfront.domain_name}"
  cloudfront_zone_id = "${module.cloudfront.hosted_zone_id}"

  dependencies = [
    "${module.s3.depended_on}",
  ]

}
