#security group for fortune cookie hosts
resource "aws_security_group" "host-fortunecookie" {
  name        = "Fortune Cookie Host"
  description = "Allow Web Traffic to Fortune Cookie hosts"
  vpc_id      = aws_vpc.fortunecookie.id
  depends_on  = [aws_internet_gateway.fortunecookie]

  # SSH from all

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-fortunecookie.id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.lb-fortunecookie.id]
  }

  # Outbound All
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.lb-fortunecookie.id]
  }
}

#security group for fortune cookie load balancer
resource "aws_security_group" "lb-fortunecookie" {
  name        = "Fortune Cookie Load Balancer"
  description = "Allow all traffic to Fortune Cookie hosts"
  vpc_id      = aws_vpc.fortunecookie.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound All
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.host-fortunecookie.id]
  }
}