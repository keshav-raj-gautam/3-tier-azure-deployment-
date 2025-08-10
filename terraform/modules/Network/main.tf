resource "azurerm_virtual_network" "v-net" {

  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space


}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name = each.value.name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes = each.value.address_prefixes
  depends_on = [ azurerm_virtual_network.v-net ]
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.subnets
  name = "${each.value.name}-nsg"
  resource_group_name = var.resource_group_name
  location = var.location
  
}


resource "azurerm_subnet_network_security_group_association" "name" {
    for_each = var.subnets
  subnet_id = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  depends_on = [ azurerm_network_security_group.nsg, azurerm_virtual_network.v-net ]
}


resource "azurerm_private_dns_zone" "dns-zone" {
  resource_group_name = var.resource_group_name
  name = var.dns_zone_name
  
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns-vnet-link" {
  resource_group_name = var.resource_group_name
  name = var.dns_vnet_link_name
  private_dns_zone_name = var.dns_zone_name
  virtual_network_id = azurerm_virtual_network.v-net.id
}

