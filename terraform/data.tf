data "terraform_remote_state" "base_state" {
  backend = "s3"
  config = {
    bucket = "myterraformcode"
    key    = "prod/base_state.tfstate"
    region = "us-east-1"
  }
}

#deploy bundle
data "archive_file" "fortune-cookie-zip" {
  type        = "zip"
  source_dir  = "../site"
  output_path = "fortune_cookie.zip"
}