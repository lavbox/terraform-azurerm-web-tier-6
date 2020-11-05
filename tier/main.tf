
variable "opcos" {
  type = list(string)
}

variable "resource_group" {
  type = object({
    name = string
    region = string
    regionPrefix = string
    tierPrefix = string
  })
}

variable "project" {
  type = object({
    name = string
    short_name = string
  })
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group.name
}

module "appserviceplan" {
  source = "./appserviceplan"
  location = var.resource_group.region
  resource_group_name = var.resource_group.name
  project_name = var.project.name
  tier = var.resource_group.tierPrefix
  region_prefix = var.resource_group.regionPrefix
}

module "rediscache" {
  source = "./rediscache"
  location = var.resource_group.region
  resource_group_name = var.resource_group.name
  project_name = var.project.name
  tier = var.resource_group.tierPrefix
  region_prefix = var.resource_group.regionPrefix
}

module "storageaccount" {
  source = "./storageaccount"
  location = var.resource_group.region
  resource_group_name = var.resource_group.name
  project_name = var.project.short_name
  tier = var.resource_group.tierPrefix
  region_prefix = var.resource_group.regionPrefix
}

module "appservice" {
  source = "./appservice"
  location = var.resource_group.region
  appserviceplan_id = module.appserviceplan.id
  resource_group_name = var.resource_group.name
  project_name = var.project.name
  tier = var.resource_group.tierPrefix
  region_prefix = var.resource_group.regionPrefix
  opcos = var.opcos
  depends_on = [module.appserviceplan, module.rediscache, module.storageaccount]
}