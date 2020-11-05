terraform {
  backend "remote" {
    organization = "eudigital"

    workspaces {
      name = "CommunitySolar"
    }
  }
}

variable "client_secret" {
  type = string
}

variable "regionPrefix" {
  type = string
}

variable "tierPrefix" {
  type = string
}

variable "opcos" {
  type = list(string)
}

variable "project_name" {
  type = string
}

variable "project_short_name" {
  type = string
}

provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
}

locals {
  resource_group = {
    name = format("XZ%s-E-N-EUWEB00-%s-RGP-10", var.regionPrefix, var.tierPrefix )
    regionPrefix = var.regionPrefix
    region = var.regionPrefix == "E" ? "eastus" : "centralus" 
    tierPrefix = var.tierPrefix
  }

  project = {
    name = var.project_name
    short_name = var.project_short_name
  }

}

data "azurerm_resource_group" "rg" {
  name = local.resource_group.name
}

module "appserviceplan" {
  source = "./modules/appserviceplan"
  location = local.resource_group.regionPrefix
  resource_group_name = local.resource_group.name
  project_name = local.project.name
  tier = local.resource_group.tierPrefix
  region_prefix = local.resource_group.regionPrefix
}

module "rediscache" {
  source = "./modules/rediscache"
  location = local.resource_group.regionPrefix
  resource_group_name = local.resource_group.name
  project_name = local.project.name
  tier = local.resource_group.tierPrefix
  region_prefix = local.resource_group.regionPrefix
}

module "storageaccount" {
  source = "./modules/storageaccount"
  location = local.resource_group.regionPrefix
  resource_group_name = local.resource_group.name
  project_name = local.project.short_name
  tier = local.resource_group.tierPrefix
  region_prefix = local.resource_group.regionPrefix
}

module "appservice" {
  source = "./modules/appservice"
  location = local.resource_group.regionPrefix
  appserviceplan_id = module.appserviceplan.id
  resource_group_name = local.resource_group.name
  project_name = local.project.name
  tier = local.resource_group.tierPrefix
  region_prefix = local.resource_group.regionPrefix
  opcos = var.opcos
  depends_on = [module.appserviceplan, module.rediscache, module.storageaccount]
}