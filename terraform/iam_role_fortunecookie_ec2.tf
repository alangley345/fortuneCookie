resource "aws_iam_instance_profile" "fortune-cookie-ec2" {
    name = "fortune-cookie-user"
    roles = [
        aws_iam_role.fortune-cookie-ec2.id,aws_iam_role.fortune-cookie-s3
    ]
}

resource "aws_iam_role" "fortune-cookie-ec2" {
    name = "fortune-cookie-ec2-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "fortune-cookie-s3" {
    name = "fortune-cookie-s3-role"
    assume_role_policy = <<EOF
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Action": "sts:AssumeRole",
              "Principal": {
                "Service": "s3.amazonaws.com"
              },
              "Effect": "Allow",
              "Sid": ""
            }
          ]
        }
    EOF
}

#resource "aws_iam_instance_profile" "beanstalk_service" {
#    name = "beanstalk-service-user"
#    roles = ["${aws_iam_role.beanstalk_service.name}"]
#}
#
#resource "aws_iam_instance_profile" "beanstalk_ec2" {
#    name = "beanstalk-ec2-user"
#    roles = ["${aws_iam_role.beanstalk_ec2.name}"]
#}
#
#resource "aws_iam_role" "beanstalk_service" {
#    name = "beanstalk-service-role"
#    assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Sid": "",
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "elasticbeanstalk.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole",
#      "Condition": {
#        "StringEquals": {
#          "sts:ExternalId": "elasticbeanstalk"
#        }
#      }
#    }
#  ]
#}
#EOF
#}