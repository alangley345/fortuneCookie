#specific provider
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#define location of state file
terraform {
  backend "s3" {
    bucket = "myterraformcode"
    key    = "fortunecookie/terraform.tfstate"
    region = "us-east-1"
  }
}