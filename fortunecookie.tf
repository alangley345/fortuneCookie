provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#creates fortune cookie VPC
resource "aws_vpc" "fortunecookie" {
  cidr_block       = "172.16.0.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "Fortune Cookie"
  }
}

#Subnet for edge devices
resource "aws_subnet" "fortunecookie" {
  vpc_id     = aws_vpc.fortunecookie.id
  cidr_block = "172.16.0.0/24"
  depends_on = [aws_vpc.fortunecookie]
  tags = {
    Name = "Fortune Cookie"
  }
}

#Internet gateway for Edge VPC
resource "aws_internet_gateway" "fortunecookie" {
  vpc_id     = aws_vpc.fortunecookie.id
  depends_on = [aws_vpc.fortunecookie]
  tags = {
    Name = "Fortune Cookie"
  }
}

#creating aws_eip
resource "aws_eip" "fortunecookie" {
  instance   = aws_instance.fortunecookie.id
  depends_on = [aws_internet_gateway.fortunecookie, aws_instance.fortunecookie]
  vpc        = true
}

#create route table for VPC
resource "aws_route_table" "fortunecookie" {
  vpc_id = aws_vpc.fortunecookie.id
  depends_on   = [aws_internet_gateway.fortunecookie, aws_vpc.fortunecookie]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fortunecookie.id]
  }

  tags = {
    Name = "Fortune Cookie"
  }
}

resource "aws_main_route_table_association" "fortunecookie" {
  vpc_id         = aws_vpc.fortunecookie.id
  route_table_id = aws_route_table.fortunecookie.id
}


#security group for bastion host
resource "aws_security_group" "fortunecookie" {
  name        = "Fortune Cookie"
  description = "Allow Web Traffic to Fortune Cookie"
  vpc_id      = aws_vpc.
  depends_on = [aws_internet_gateway.fortunecookie]
  
  # SSH from all
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound All
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#creates base for building out web app
resource "aws_instance" "fortunecookie" {
  ami           = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name = "x1Carbon"
  
  provisioner "local-exec" {
    command  = "sleep 60" 
  }

  provisioner "local-exec" {
    command  = "sudo systemctl start nginx" 
  }
}

terraform {
  backend "s3" {
    bucket="myterraformcode"
    key="fortunecookie/terraform.tfstate"
    region="us-east-1"  
  }
}