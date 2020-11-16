provider "azurerm" {
  version = "2.36.0"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "labsstrg"
    container_name       = "labs-tfstate"
    key                  = "labs-terraform.state"
  }
}

module "virtual_network" {
  source                    = "./modules/azure_virtual_network"
  network_name              = var.network_name
  network_cidr              = var.network_cidr
  service_endpoints         = var.service_endpoints
  location                  = var.location
  private_zone_name         = var.private_zone_name
  private_subnets           = var.private_subnets
  public_subnets            = var.public_subnets
}


output "infra_virtual_network_name" {
  value = module.virtual_network.infra_virtual_network_name
}

output "infra_virtual_network_id" {
  value = module.virtual_network.infra_virtual_network_id
}

output "virtual_network_resource_group" {
  value = module.virtual_network.network_resource_group
}

output "base_network_security_group" {
  value = module.virtual_network.base_nsg_id
}

output "public_subnet_ids" {
  value = module.virtual_network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.virtual_network.private_subnet_ids
}
