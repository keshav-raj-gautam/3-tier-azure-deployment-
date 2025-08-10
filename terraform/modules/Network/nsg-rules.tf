resource "azurerm_network_security_rule" "http_inbound" {
  description = "This rule is for db port 27017 inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet1"].name
  resource_group_name = var.resource_group_name
  priority = 100
  name = "AllowHTTPInbound"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "27017"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "app-gw-http" {
  description = "This rule is for app gateway port 80 inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet4"].name
  resource_group_name = var.resource_group_name
  priority = 100
  name = "AllowHTTPInbound"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "80"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "http_inbound2" {
  description = "This rule is for frontend port 80 inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet2"].name
  resource_group_name = var.resource_group_name
  priority = 100
  name = "AllowHTTPInbound"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "80"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "http_inbound3" {
 description = "This rule is for backend port 80 inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet3"].name
  resource_group_name = var.resource_group_name
  priority = 100
  name = "AllowHTTPInbound"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "80"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "jumpbox-ssh" {
    description = "This rule is for jumpbox port 22 inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet5"].name
  resource_group_name = var.resource_group_name
  priority = 100
  name = "AllowSSHInbound"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "app-gw-nsg-rule" {
    description = "This rule is for app-gw required port inbound"
  network_security_group_name = azurerm_network_security_group.nsg["subnet4"].name
  resource_group_name = var.resource_group_name
  priority = 110
  name = "AllowSpecificTrafficOnAppGW"
  direction = "Inbound"
  access = "Allow"
  protocol = "*"
  source_port_range = "*"
  destination_port_range = "65200-65535"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}