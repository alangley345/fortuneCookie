provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


#creates base for building out web app
resource "aws_instance" "fortunecookie_base" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name = "fortuneCookie"
<<<<<<< HEAD
}

=======
  
  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}




>>>>>>> f1b62d34208aaccd6c9c5a3d5f7ddbf63a748b4b
terraform {
  backend "s3" {
  bucket="myterraformcode"
  key="fortunecookie/terraform.tfstate"
  region="us-east-1"  
  }
}