terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
  }
}

provider "mongodbatlas" {

}

#define location of state file
terraform {
  backend "s3" {
    bucket = "myterraformcode"
    key    = "prod/fortune_cookie.tfstate"
    region = "us-east-1"
  }
}