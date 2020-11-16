variable "network_name" {}
variable "location" {}
variable "network_cidr" {}
variable "public_subnets" {
  type = map
}
variable "private_subnets" {
  type = map
}
variable "private_zone_name" {
  default = "labs.io"
}
variable "service_endpoints" {
  type    = list(string)
  default = []
}
variable "client_id" {}
variable "client_secret" {}
