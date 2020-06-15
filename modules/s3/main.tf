resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
        "Sid":"AddPerm",
        "Effect":"Allow",
          "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF

  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]

}

resource "null_resource" "dependency_setter" {
  depends_on = [
  ]
}