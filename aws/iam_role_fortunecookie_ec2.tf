resource "aws_iam_instance_profile" "fortune-cookie-ec2" {
  name = "fortune-cookie-ec2-user"
  role = aws_iam_role.fortune-cookie-ec2.id
}

resource "aws_iam_role" "fortune-cookie-ec2" {
  name               = "fortune-cookie-ec2-role"
  assume_role_policy = <<EOF
{"Version": "2012-10-17",
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

resource "aws_iam_instance_profile" "fortune-cookie-s3" {
  name = "fortune-cookie-s3-user"
  role = aws_iam_role.fortune-cookie-s3.id
}

resource "aws_iam_role" "fortune-cookie-s3" {
  name               = "fortune-cookie-s3-role"
  assume_role_policy = <<EOF
{"Version": "2012-10-17",
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

#resource "aws_iam_instance_profile" "fortune-cookie-cw" {
#  name = "fortune-cookie-cw-user"
#  role = aws_iam_role.fortune-cookie-cw.id
#}
#
#resource "aws_iam_role" "fortune-cookie-cw" {
#  name               = "fortune-cookie-cw-role"
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": [
#        "logs:CreateLogGroup",
#        "logs:CreateLogStream",
#        "logs:PutLogEvents",
#        "logs:DescribeLogStreams"
#    ],
#      "Principal": [
#        "${aws_cloudwatch_log_group.fortune-cookie.arn}"
#    ]
#  }
# ]
#}
#    EOF
#}