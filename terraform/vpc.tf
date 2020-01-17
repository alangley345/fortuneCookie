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
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

}


#Subnet for fortune cookie 1
resource "aws_subnet" "fortunecookie1" {
  vpc_id            = aws_vpc.fortunecookie.id
  cidr_block        = "172.16.0.0/25"
  depends_on        = [aws_vpc.fortunecookie]
  availability_zone = "us-east-1a"
  tags = {
    Name = "Fortune Cookie"
  }
}

#Subnet for fortune cookie 2
resource "aws_subnet" "fortunecookie2" {
  vpc_id            = aws_vpc.fortunecookie.id
  cidr_block        = "172.16.0.128/25"
  depends_on        = [aws_vpc.fortunecookie]
  availability_zone = "us-east-1b"
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