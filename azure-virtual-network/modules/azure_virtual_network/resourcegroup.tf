resource "azurerm_resource_group" "infra_rg" {
  name     = "${var.network_name}-network-rg"
  location = var.location

  tags = {
    Name        = "${var.network_name}-network-rg"
  }
}

output "network_resource_group" {
  value = azurerm_resource_group.infra_rg.name
}
