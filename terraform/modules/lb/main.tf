resource "azurerm_lb" "lb" {
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.lb_name
  sku = var.lb_sku
  frontend_ip_configuration {
    name = var.lb_ip_config_name
    subnet_id = var.lb_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name = var.backend_lb_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "http" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "http-probe"
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "name" {
  loadbalancer_id = azurerm_lb.lb.id
  name = "LBhttpRule"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
  backend_port = var.backend_port
  frontend_port = var.frontend_port
  frontend_ip_configuration_name = var.lb_ip_config_name
  protocol = "Tcp"
}

