provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}

data "azurerm_resource_group" "rg" {
  name     = "davoodapm"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = "eastus"
  resource_group_name = data.azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}