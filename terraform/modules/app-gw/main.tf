resource "azurerm_public_ip" "app-gw-pip" {
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.pip_name
  allocation_method = "Static"
}


resource "azurerm_application_gateway" "app-gw" {
  name = var.appgw_name
  resource_group_name = var.resource_group_name
  location = var.location

  sku {
    name = "Basic"
    tier = "Basic"
    capacity = "1"
}

gateway_ip_configuration {
  name = var.gateway_ip_configuration_name
  subnet_id = var.gw_subnet_id
}

frontend_ip_configuration {
  name = var.frontend_ip_configuration_name
  public_ip_address_id = azurerm_public_ip.app-gw-pip.id
  }

backend_address_pool {
  name = var.backend_address_pool_name

}

frontend_port {
    name = var.frontend_port_name
  port = 80

}

http_listener {
  name = var.http_listener_name
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  frontend_port_name = var.frontend_port_name
  protocol = "Http"
}

backend_http_settings {
  name = var.backend_http_settings_name
  cookie_based_affinity = "Disabled"
  port = "80"
  protocol = "Http"
}
probe {
  name                = "custom-health-probe"
    protocol            = "Http"
    path                = "/health"
    interval            = 30
    host = "127.0.0.1"
    timeout             = 30
    unhealthy_threshold = 3
}

request_routing_rule {
  name = var.request_routing_rule_name
  rule_type = "Basic"
  http_listener_name = var.http_listener_name
  backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.backend_http_settings_name
    priority                   = 1
}

}