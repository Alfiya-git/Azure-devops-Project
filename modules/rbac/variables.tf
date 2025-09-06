variable "scope" {
  type = string
}

variable "admins" {
  type    = list(string)
  default = []
}

variable "developers" {
  type    = list(string)
  default = []
}
