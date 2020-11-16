variable "sshkey" {
  default = "~/.ssh/id_rsa.pub"
}

variable "location" {
  default = "eastus"
}

variable "vm_size" {
  type = map
}

variable "client_id" {}
variable "client_secret" {}
variable "rhel7_os_distro_image" {}
variable "server_names" {}
