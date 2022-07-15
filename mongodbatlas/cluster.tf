resource "mongodbatlas_cluster" "my-shared-cluster" {
  project_id              = mongodbatlas_project.fortune-cookie.id
  name                    = "MySharedCluster"

  # Provider Settings "block"
  provider_name = "TENANT"
  backing_provider_name = "AWS"
  provider_region_name = "US_EAST_1"
  provider_instance_size_name = "M0"
}