variable "env" {
  type    = string
  default = "staging"
}

variable "location_primary" {
  type    = string
  default = "West US"
}

variable "location_secondary" {
  type    = string
  default = "Central US"
}

variable "admin_ids" {
  type    = list(string)
  default = []
}

variable "developer_ids" {
  type    = list(string)
  default = []
}
