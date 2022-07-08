# Create elastic beanstalk application

resource "aws_elastic_beanstalk_application" "fortune-cookie" {
  name = "fortune-cookie"
}

# Create elastic beanstalk Environment

resource "aws_elastic_beanstalk_environment" "fortune-cookie-env" {
  name                = "fortune-cookie-env"
  application         = aws_elastic_beanstalk_application.fortune-cookie.name
  solution_stack_name = "64bit Amazon Linux 2 v5.5.4 running Node.js 16"
  tier                = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.fortune-cookie-ec2.id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.fortune-cookie-s3.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = data.terraform_remote_state.base_state.outputs.prod_ext_sub_0_id
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.nano"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.terraform_remote_state.base_state.outputs.prod_ext_vpc_id
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 1
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  tags = {
    purpose     = "fortunecookieapp"
    Environment = "production"
  }

}