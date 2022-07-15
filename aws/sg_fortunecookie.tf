resource "aws_security_group" "allow-nodejs" {
  name        = "allow-nodejs"
  description = "Allow traffic to Node.js for testing"
  vpc_id      = data.terraform_remote_state.base_state.outputs.prod_ext_vpc_id

  ingress {
    description      = "Node.JS default port"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "allow-nodejs"
    Environment = "prod"
    Purpose     = "fortunecookie"
  }
}