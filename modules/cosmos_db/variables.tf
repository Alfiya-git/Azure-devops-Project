variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "account_name" {
  type = string
}

variable "geo_locations" {
  type    = list(string)
  default = []
}
