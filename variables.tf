# Must be set to this region for ACM to work
}
variable "aws_region" {
  default = "us-east-1" 

# The domain name of the website
variable "domain_name" {
  default = ""
}

# The s3 bucket name - best set the same as the domain name
variable "bucket_name" {
  default = ""
}

# The name of the hosted zone set up manually in Route53
variable "hosted_zone" {
  default = ""
}