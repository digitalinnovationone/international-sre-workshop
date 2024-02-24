terraform {
  required_version = ">= 1.1.7, < 2.0.0"
  required_providers {
    azurerm = {
      version = "~>3.47.0"
      source  = "hashicorp/azurerm"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>1.2.24"
    }
  }

  backend "azurerm" {
    # Empty since we will configure this dynamically in GitHub Actions
  }
}

provider "azurerm" {
  features {}
}

# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}