resource "azurerm_network_security_group" "base_nsg" {
    name                = "base-nsg"
    location            = var.location
    resource_group_name = azurerm_resource_group.infra_rg.name
   
    security_rule {
        name                       = "base-nsg-rules"
        priority                   = 1010
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = ""
        destination_port_ranges    = ["22","80","443","3000","8000","8080","8500","8443","9000","9093","9115","9090","12345"]
        source_address_prefix      = "*"
        destination_address_prefixes = var.network_cidr
    }
}


output "base_nsg_id" {
  value = azurerm_network_security_group.base_nsg.id
}


