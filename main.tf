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
  client_id     = "d83c10ac-a695-4985-90e4-c869146c916a"
  client_secret = "ASM-_4SEu35nG3WATr77mdP6pG7q_g~zz~"
  tenant_id     = "f32b97f0-efb8-4bc3-91ee-18a6e5f635c9"
  subscription_id = "3a2c2a59-bf2d-4627-93c9-8ec680a11884"
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

module "tier" {
  source = "./tier"
  resource_group = local.resource_group
  project = local.project
  opcos = var.opcos
}