output "lb_backend_address_pool" {
  
  value = azurerm_lb_backend_address_pool.lb_backend_pool.id


}

output "private_ip_address" {
  value = azurerm_lb.lb.frontend_ip_configuration[0].private_ip_address
}
