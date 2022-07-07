resource "aws_s3_bucket" "resume" {
  bucket = "fortune.aaronlangley.net"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

}