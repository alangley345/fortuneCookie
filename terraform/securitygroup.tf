//Rules for Fortune Cookie hosts

#defining security group roles to avoid a cycle
resource "aws_security_group" "host-fortunecookie" {
  name = "SG-Fortune Cookie Host"
  description = "Fortune Cookie Host Group"
  vpc_id      = aws_vpc.fortunecookie.id
}

#http in host rule
resource "aws_security_group_rule" "http-to-host" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.host-fortunecookie.id
    source_security_group_id = aws_security_group.lb-fortunecookie.id
}

#egress ALL rule
resource "aws_security_group_rule" "outbound-to-lb" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.host-fortunecookie.id
    source_security_group_id = aws_security_group.lb-fortunecookie.id
}

//Rules for Fortune Cookie load balancer

#defining security group roles to avoid a cycle
resource "aws_security_group" "lb-fortunecookie" {
  name = "SG-Fortune Cookie LB"
  description = "Fortune Cookie Loadbalancer Group"
  vpc_id      = aws_vpc.fortunecookie.id
}

#Ingress https
resource "aws_security_group_rule" "lb-https-listener" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_group_id = aws_security_group.lb-fortunecookie.id
    cidr_blocks = ["0.0.0.0/0"]
}

#Ingress http
resource "aws_security_group_rule" "lb-http-listener" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.lb-fortunecookie.id
    cidr_blocks = ["0.0.0.0/0"]
}

#Egress http 
resource "aws_security_group_rule" "lb-to-host" {
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.lb-fortunecookie.id
    source_security_group_id = aws_security_group.host-fortunecookie.id
}