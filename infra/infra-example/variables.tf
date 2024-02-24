
variable "default_location" {
  type        = string
  description = "Set a custom value for the default location"
  default     = "westeurope"
}

variable "environment_name" {
  type        = string
  description = "The environment name"
  default     = "dev"
}


variable "rg_name" {
  type        = string
  description = "The environment name"  
}


variable "appservice_plan_id" {
  type        = string
  description = "The environment name"  
}
