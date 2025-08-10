output "app-gw-pip" {
  value = module.app-gw.app_gw_public_ip.ip_address
}

output "jumpbox-pip" {
  value = module.jumpbox.jumpbox-pip.ip_address
}