
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
  redis_cache_name = format("XZ%s-E-N-%s-%s-RCH-01", var.region_prefix, var.project_name, var.tier)
}

resource "azurerm_redis_cache" "rediscache" {
  name                = local.redis_cache_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}