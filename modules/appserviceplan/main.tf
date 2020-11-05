
variable "location" {
  type = "string"
}

variable "project_name" {
  type = "string"
}


variable "region_prefix" {
  type = "string"
}

variable "tier" {
  type = "string"
}

variable "resource_group_name" {
  type = "string"
}

locals {
  appservice_plan_name = format("XZ%s-E-N-%s-%s-ASP-10", var.region_prefix, var.project_name, var.tier)
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = local.appservice_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

output "id" {
  value = azurerm_app_service_plan.appserviceplan.id
}