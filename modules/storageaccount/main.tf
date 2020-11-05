
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
  storage_account_name = format("xz%sen%s%sstg01", lower(var.region_prefix), lower(var.project_name), lower(var.tier))
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}