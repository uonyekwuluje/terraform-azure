resource "azurerm_private_dns_zone" "private" {
  name                = var.private_zone_name
  resource_group_name = azurerm_resource_group.infra_rg.name

  tags = {
      Name        = var.private_zone_name
  }
}


resource "azurerm_virtual_network" "core_virtual_network" {
    name                = var.network_name
    address_space       = var.network_cidr
    location            = var.location
    resource_group_name = azurerm_resource_group.infra_rg.name

    tags = {
      Name = var.network_name
    }
}


resource "azurerm_private_dns_zone_virtual_network_link" "private" {
    name                  = "${var.private_zone_name}-link"
    resource_group_name   = azurerm_resource_group.infra_rg.name
    private_dns_zone_name = azurerm_private_dns_zone.private.name
    virtual_network_id    = azurerm_virtual_network.core_virtual_network.id
    registration_enabled  = true

    tags = {
      Name        = "${var.private_zone_name}-link"
  }
}



resource "azurerm_subnet" "public_service_subnet" {
  for_each             = var.public_subnets
  name                 = each.key
  virtual_network_name = azurerm_virtual_network.core_virtual_network.name
  resource_group_name  = azurerm_resource_group.infra_rg.name
  address_prefixes     = [each.value]
  service_endpoints    = var.service_endpoints
  depends_on           = [azurerm_virtual_network.core_virtual_network]
}

resource "azurerm_subnet" "private_service_subnet" {
  for_each             = var.private_subnets
  name                 = each.key
  virtual_network_name = azurerm_virtual_network.core_virtual_network.name
  resource_group_name  = azurerm_resource_group.infra_rg.name
  address_prefixes     = [each.value]
  service_endpoints    = var.service_endpoints
  depends_on           = [azurerm_virtual_network.core_virtual_network]
}




output "infra_virtual_network_name" {
  value = azurerm_virtual_network.core_virtual_network.name
}

output "infra_virtual_network_id" {
  value = azurerm_virtual_network.core_virtual_network.id
}

output "public_subnet_ids" {
  value = { for subnet, id in azurerm_subnet.public_service_subnet : subnet => azurerm_subnet.public_service_subnet[subnet].id }
}

output "private_subnet_ids" {
  value = { for subnet, id in azurerm_subnet.private_service_subnet : subnet => azurerm_subnet.private_service_subnet[subnet].id }
}
