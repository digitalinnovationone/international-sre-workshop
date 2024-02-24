default_location    = "westeurope"
environment_name    = "dev"
rg_name             = "rg-dio-${var.environment_name}-${var.location}"
appservice_plan_id  = "dioserviceplan${var.environment_name}"

