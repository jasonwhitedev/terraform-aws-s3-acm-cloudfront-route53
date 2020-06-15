output "s3_www_website_endpoint" {
  value = "${aws_s3_bucket.b.website_endpoint}"
}

output "s3_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.b.bucket_regional_domain_name}"
}

output "depended_on" {
  value = "${null_resource.dependency_setter.id}"
}