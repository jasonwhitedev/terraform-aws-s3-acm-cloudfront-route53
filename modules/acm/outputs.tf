output "certificate_arn" {
  value = "${aws_acm_certificate.cert.arn}"
}

output "certificate_validation" {
  value = "${aws_acm_certificate_validation.cert}"
}

output "depended_on" {
  value = "${null_resource.dependency_setter.id}"
}