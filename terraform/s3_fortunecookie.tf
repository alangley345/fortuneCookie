resource "aws_s3_bucket" "fortune-cookie" {
  bucket = "fortune.aaronlangley.net"

  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_s3_bucket_acl" "fortune-cookie" {
  bucket = aws_s3_bucket.fortune-cookie.id
  acl    = "private"
}