resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

data "aws_route53_zone" "zone" {
  name         = "${var.hosted_zone}"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.zone.id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${var.cloudfront_domain_name}"
    zone_id                = "${var.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    "aws_route53_record.www"
  ]
}