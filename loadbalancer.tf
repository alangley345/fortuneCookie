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
resource "aws_alb" "fortunecookie" {
  name                             = "fortunecookie-loadbalancer"
  internal                         = false
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  subnets                          = [aws_subnet.fortunecookie1.id, aws_subnet.fortunecookie2.id]
  security_groups                  = [aws_security_group.fortunecookie.id]
  
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
resource "aws_alb_listener" "fortunecookie" {
  load_balancer_arn = aws_alb.fortunecookie.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.myaws.arn
  default_action {
      target_group_arn = aws_alb_target_group.fortunecookie.arn
      type             = "forward"
  }
}

resource "aws_alb_listener" "fortunecookie" {
  load_balancer_arn = aws_alb.fortunecookie.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type            = "redirect"
    redirect {
      port          = "443"
      protocol      = "HTTPS"
      status_code   = "HTTP_301"
    }
  }
}


#specify listener rules
resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = [aws_alb_target_group.fortunecookie]  
  listener_arn = aws_alb_listener.fortunecookie.arn  
  
  action {    
    type             = "redirect"    
    redirect {
      port        = 80
      protocol    = "tcp"
      status_code =  "HTTP_301"   
      } 
  }

   condition {
    http_header {
      http_header_name = "X-Forwarded_For"
      values           = ["172.16.0.*"]
    }
  }
}