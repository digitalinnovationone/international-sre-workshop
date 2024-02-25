# ------------------------------------------------------------------------------------------------------
# Deploy app service plan
# ------------------------------------------------------------------------------------------------------
resource "azurecaf_name" "plan_name" {
  name          = var.appservice_plan_id
  resource_type = "azurerm_app_service_plan"
  random_length = 0
  clean_input   = true
}

resource "azurerm_service_plan" "plan" {
  name                = azurecaf_name.plan_name.result
  location            = var.default_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "B1"
}

# ------------------------------------------------------------------------------------------------------
# Deploy app service web app
# ------------------------------------------------------------------------------------------------------
resource "azurecaf_name" "web_name" {
  name          = "dio-webapp-${var.environment_name}"
  resource_type = "azurerm_app_service"
  random_length = 0
  clean_input   = true
}

resource "azurerm_linux_web_app" "web" {
  name                = azurecaf_name.web_name.result
  location            = var.default_location
  resource_group_name = var.rg_name
  service_plan_id     = var.appservice_plan_id
  https_only          = true

    site_config {
        always_on         = true
        use_32_bit_worker = false
        ftps_state        = "FtpsOnly"
        app_command_line  = ""
        application_stack {
        python_version = "3.8"
        }
        health_check_path = "/"
    }
}
