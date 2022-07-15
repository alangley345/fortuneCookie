resource "aws_cloudwatch_log_group" "fortune-cookie" {
  name = "fortune-cookie"

  tags = {
    nvironment = "prod"
    Purpose    = "fortunecookie"
  }
}