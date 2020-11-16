variable "network_name" {}
variable "location" {}
variable "network_cidr" {}
variable "service_endpoints" {}
variable "private_zone_name" {}
variable "public_subnets" {
  type = map
}

variable "private_subnets" {
  type = map
}
