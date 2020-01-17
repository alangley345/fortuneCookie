data "aws_ami" "fortunecookie" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["fortunecookie *"]
  }
}

#creates base for building out web app
resource "aws_launch_configuration" "fortunecookie" {
  image_id        = data.aws_ami.fortunecookie.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.host-fortunecookie.id]
  key_name        = "fortuneCookie"

  lifecycle {
    create_before_destroy = true
  }
}

#creates autoscaling group for fortunecookie site
resource "aws_autoscaling_group" "fortunecookie" {
  name                      = "fortunecookie autoscaling group"
  max_size                  = "2"
  min_size                  = "2"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.fortunecookie.id
  vpc_zone_identifier       = [aws_subnet.fortunecookie1.id, aws_subnet.fortunecookie2.id]
}

