#targeting port 80 instances
resource "aws_alb_target_group" "fortunecookie" {
  name     = "fortuneookie-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.fortunecookie.id

  health_check {
    interval            = 30
    path                = "/etc"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

#creating network load balancer
resource "aws_alb" "fc" {
  name                             = "fc"
  internal                         = false
  load_balancer_type               = "application"
  idle_timeout                     = "75"
  enable_cross_zone_load_balancing = true
  subnets                          = [aws_subnet.fortunecookie1.id, aws_subnet.fortunecookie2.id]
  security_groups                  = [aws_security_group.fortunecookie.id]
  
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