#specific provider
provider "aws" {
  region = "us-east-1"
}

#define location of state file
terraform {
  backend "s3" {
    bucket = "myterraformcode"
    key    = "prod/fortune_cookie.tfstate"
    region = "us-east-1"
  }
}