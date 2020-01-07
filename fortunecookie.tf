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

resource "aws_default_network_acl" "fortunecookie" {
  default_network_acl_id = aws_vpc.fortunecookie.default_network_acl_id
  depends_on             = [aws_vpc.fortunecookie]

  #egress rules
  egress {
    rule_no    = 100
    protocol   = "icmp"
    from_port  = -1
    to_port    = -1
    icmp_type  = -1
    icmp_code  = -1
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  egress {
    protocol   = "-1"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  #ingress rule
  ingress {
    rule_no    = 100
    protocol   = "icmp"
    from_port  = -1
    to_port    = -1
    icmp_type  = -1
    icmp_code  = -1
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 250
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
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

#Internet gateway for Fortune Cookie VPC
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
  vpc_id     = aws_vpc.fortunecookie.id
  depends_on = [aws_internet_gateway.fortunecookie, aws_vpc.fortunecookie]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fortunecookie.id
  }

  tags = {
    Name = "Fortune Cookie"
  }
}

resource "aws_main_route_table_association" "fortunecookie" {
  vpc_id         = aws_vpc.fortunecookie.id
  route_table_id = aws_route_table.fortunecookie.id
}


#security group for fortune cookie host
resource "aws_security_group" "fortunecookie" {
  name        = "Fortune Cookie"
  description = "Allow Web Traffic to Fortune Cookie"
  vpc_id      = aws_vpc.fortunecookie.id
  depends_on  = [aws_internet_gateway.fortunecookie]

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
#ip output
output "ip" {
  value = aws_instance.fortunecookie.public_ip
}

#creates base for building out web app
resource "aws_instance" "fortunecookie" {
  ami                         = "ami-00068cd7555f543d5"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.fortunecookie.id
  vpc_security_group_ids      = [aws_security_group.fortunecookie.id]
  associate_public_ip_address = "true"
  key_name                    = "fortuneCookie"
}

#define location of state file
terraform {
  backend "s3" {
    bucket = "myterraformcode"
    key    = "fortunecookie/terraform.tfstate"
    region = "us-east-1"
  }
}