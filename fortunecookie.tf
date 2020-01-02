provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws instance" "fortunecookie_base" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
}

terraform {
backend "s3" {
bucket="myterraformcode"
key="fortunecookie/terraform.tfstate"
region="us-east-1"
}
}