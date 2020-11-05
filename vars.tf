variable "regionPrefix" {
  type = string
}

variable "tierPrefix" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_short_name" {
  type = string
}

variable "opcos" {
  type = set(string)
  default =  [
    "BGE",
    "COMED",
    "PECO",
    "DPL",
    "ACE",
    "PEPCO"
  ]
}