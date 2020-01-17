#targeting port 80 instances
resource "aws_alb_target_group" "fortunecookie" {
  name     = "fortuneookie-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.fortunecookie.id

  health_check {
    interval            = 30
    path                = "/var/website"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
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

#creating application load balancer
resource "aws_alb" "fc" {
  name                             = "fc"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [aws_subnet.fortunecookie1.id, aws_subnet.fortunecookie2.id]
  security_groups                  = [aws_security_group.lb-fortunecookie.id]
  
}

#get primary zone
data "aws_route53_zone" "greatcatlab" {
  name = "greatcatlab.net"
}
#DNS entry for fortunecookie.greatcatlab.net
resource "aws_route53_record" "fortunecookie" {
  zone_id = data.aws_route53_zone.greatcatlab.zone_id
  name    = "fortunecookie.${data.aws_route53_zone.greatcatlab.name}"
  type    = "A"

  alias {
    name                   = aws_alb.fc.dns_name
    zone_id                = aws_alb.fc.zone_id
    evaluate_target_health = true
  }
}

#Autoscaling Attachment
resource "aws_autoscaling_attachment" "fortunecookie" {
  alb_target_group_arn   = aws_alb_target_group.fortunecookie.arn
  autoscaling_group_name = aws_autoscaling_group.fortunecookie.id
}

# Find a certificate that is issued
data "aws_acm_certificate" "myaws" {
  domain   = "*.greatcatlab.net"
  statuses = ["ISSUED"]
}

#specify listener
resource "aws_alb_listener" "fc-frontend-443" {
  load_balancer_arn = aws_alb.fc.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.myaws.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.fortunecookie.arn
    
  }
}

resource "aws_alb_listener" "fc-frontend-80" {
  load_balancer_arn = aws_alb.fc.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    order           = 1
    type            = "redirect"
    redirect {
      host          = "#{host}"
      path          = "/#{path}"
      query         = "#{query}"
      port          = "443"
      protocol      = "HTTPS"
      status_code   = "HTTP_301"
    }
  }
}