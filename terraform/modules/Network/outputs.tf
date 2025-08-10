output "subnet_ids" {
  value = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}
output "dns_zone_name" {
  value = azurerm_private_dns_zone.dns-zone.name
}