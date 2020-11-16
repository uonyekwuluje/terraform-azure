resource "azurerm_public_ip" "publicIPAddress" {
    for_each            = toset(var.server_name)
    name                = "${lower(each.key)}-Pip"
    location            = var.location
    resource_group_name = var.infra_resource_group
    allocation_method            = "Static"
    idle_timeout_in_minutes      = 30
}

resource "azurerm_network_interface" "publicNetworkInterface" {
    for_each            = toset(var.server_name)
    name                = "${lower(each.key)}-Nic"
    location            = var.location
    resource_group_name = var.infra_resource_group

    ip_configuration {
        name                          = "${lower(each.key)}-Ip"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = var.subnet_id
        public_ip_address_id = azurerm_public_ip.publicIPAddress[each.value].id    
    }
}


resource "azurerm_network_interface_security_group_association" "webAccessNSG" {
  for_each                  = toset(var.server_name)
  network_interface_id      = azurerm_network_interface.publicNetworkInterface[each.value].id
  network_security_group_id = var.nsg_id
}


resource "azurerm_linux_virtual_machine" "PublicHost" {
    for_each              = toset(var.server_name)
    name                  = lower(each.key)
    location              = var.location
    resource_group_name   = var.infra_resource_group
    network_interface_ids = [azurerm_network_interface.publicNetworkInterface[each.value].id]
    size                  = var.vm_size
    computer_name         = lower(each.key)
    admin_username        = "azureuser"
    allow_extension_operations = true
    provision_vm_agent = true

    os_disk {
        name              = "${lower(each.key)}-dsk"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = var.vm_sku_specs["publisher"]
      offer     = var.vm_sku_specs["offer"]
      sku       = var.vm_sku_specs["sku"]
      version   = var.vm_sku_specs["version"]
    }

    disable_password_authentication = true

    admin_ssh_key {
       username   = "azureuser"
       public_key = file(var.sshkey)
    }

    tags = {
      Name = lower(each.key)
    }
}

output "public_linuxserver_priv_ip" {
  description = "private ip addresses"
  value       = [for private_ip in azurerm_network_interface.publicNetworkInterface: private_ip.private_ip_address]
}

output "public_linuxserver_pub_ip" {
  description = "public ip addres"
  value       = [for public_ip in azurerm_public_ip.publicIPAddress: public_ip.ip_address]
}
