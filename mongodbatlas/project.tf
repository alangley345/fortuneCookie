resource "mongodbatlas_project" "fortune-cookie" {
  name   = "Fortune Cookie"
  org_id = var.mongodbatlas_org_id
  #project_owner_id = "<OWNER_ACCOUNT_ID>"

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true
}