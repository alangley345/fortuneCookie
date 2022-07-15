resource "mongodbatlas_database_user" "fortune-cookie" {
  username           = aws_iam_role.test.arn
  project_id         = mongodbatlas_project.fortune-cookie.id
  auth_database_name = "$external"
  aws_iam_type       = "ROLE"

  roles {
    role_name     = "readAnyDatabase"
    database_name = "admin"
  }

  labels {
    key   = "%s"
    value = "%s"
  }

  scopes {
    name   = mongodbatlas_cluster.my-shared-cluster.name
    type = "CLUSTER"
  }
}