resource "aws_elastic_beanstalk_application_version" "fortune-cookie" {
  name        = aws_s3_object.code-bundle.id
  application = aws_elastic_beanstalk_application.fortune-cookie.name
  description = "Versioned by Terraform"
  bucket      = aws_s3_bucket.fortune-cookie.id
  key         = aws_s3_object.code-bundle.id

  depends_on = [
    aws_s3_object.code-bundle
  ]
}

resource "local_file" "app-version" {
  content  = aws_elastic_beanstalk_application_version.fortune-cookie.key
  filename = "app-version.txt"
}