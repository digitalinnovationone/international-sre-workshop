default_location    = "westeurope"
environment_name    = "prd"
rg_name             = "rg-dio-${var.environment_name}-${var.location}"
appservice_plan_id  = "dioserviceplan${var.environment_name}"
