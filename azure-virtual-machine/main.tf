provider "azurerm" {
  version = "2.36.0"
  features {}
}

data "terraform_remote_state" "network" {
  backend = "azurerm" 
  config = {
    storage_account_name = "labsstrg"
    container_name       = "labs-tfstate"
    key                  = "labs-terraform.state"
  }
}

terraform {
  backend "azurerm" {
    storage_account_name = "labsstrg"
    container_name       = "labs-tfstate"
    key                  = "labs-machine-terraform.state"
  }
}

module "public_vmachines" {
  source                    = "./modules/azure_pub_vmachines"
  server_name               = var.server_names
  vm_sku_specs              = var.rhel7_os_distro_image
  vm_size                   = var.vm_size["vm_2_by_4"]
  sshkey                    = var.sshkey
  subnet_id                 = data.terraform_remote_state.network.outputs.public_subnet_ids["public1_network"]
  infra_resource_group      = data.terraform_remote_state.network.outputs.virtual_network_resource_group
  location                  = var.location
  nsg_id                    = data.terraform_remote_state.network.outputs.base_network_security_group
}

output "Public_Infra_Server_Public_IP" {
  value = module.public_vmachines.public_linuxserver_pub_ip
}
output "Public_Infra_Server_Private_IP" {
  value = module.public_vmachines.public_linuxserver_priv_ip
}
