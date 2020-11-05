variable "client_secret" {
  type = string
}
variable "client_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "subscription_id" {
  type = string
}

variable "regionPrefix" {
  type = string
}

variable "tierPrefix" {
  type = string
}

variable "opcos" {
  type = set(string)
}

variable "project_name" {
  type = string
}

variable "project_short_name" {
  type = string
}