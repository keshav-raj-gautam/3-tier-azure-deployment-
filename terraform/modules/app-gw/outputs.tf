output "app_gw_public_ip" {
  value = azurerm_public_ip.app-gw-pip
}

output "backend_address_pool" {
  value = [
    for pool in azurerm_application_gateway.app-gw.backend_address_pool : pool.id
  ]
}