
variable "location" {
  type = "string"
}

variable "appserviceplan_id" {
  type = "string"
}

variable "opcos" {
  type = set(string)
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

resource "azurerm_app_service" "appservice" {
  for_each = var.opcos

  name                = format("%s-%s-%s-%s-UI-01", var.tier, var.region_prefix, var.project_name, each.value)
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.appserviceplan_id

  site_config {
    always_on                 = true
    use_32_bit_worker_process = true
    http2_enabled             = true
    min_tls_version           = "1.2"
  }

  # app_settings = {
  #   "SOME_KEY" = "some-value"
  # }

  # connection_string {
  #   name  = "Database"
  #   type  = "SQLServer"
  #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  # }
}