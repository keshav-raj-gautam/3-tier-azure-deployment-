resource "azurerm_resource_group" "rg" {

  name     = var.resource_group_name
  location = var.location

}

module "Network" {
  source              = "./modules/Network/"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  location            = var.location
  subnets             = var.subnets
  dns_zone_name       = var.dns_zone_name
  dns_vnet_link_name  = var.dns_vnet_link_name



  depends_on = [azurerm_resource_group.rg]

}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  acr_sku             = var.acr_sku
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_resource_group.rg]
}

module "app-gw" {

  source                         = "./modules/app-gw"
  appgw_name                     = var.appgw_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  vnet_name                      = var.vnet_name
  pip_name                       = var.pip_name
  gw_subnet_id                   = module.Network.subnet_ids["subnet4"]
  backend_address_pool_name      = var.backend_address_pool_name
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  request_routing_rule_name      = var.request_routing_rule_name
  http_listener_name             = var.http_listener_name
  frontend_port_name             = var.frontend_port_name
  gateway_ip_configuration_name  = var.gateway_ip_configuration_name
  backend_http_settings_name     = var.backend_http_settings_name

  depends_on = [azurerm_resource_group.rg]

}


# locals {
#   vmss_name_map = {
#     "db-vmss" = module.Network.subnet_ids["subnet1"]
#     "frontend-vmss" = module.Network.subnet_ids["subnet2"]
#     "backend-vmss"  = module.Network.subnet_ids["subnet3"]
#   }
# }
locals {
  vmss_info_map = {
    "frontend-vmss" = {
      subnet_id                                    = module.Network.subnet_ids["subnet2"]
      application_gateway_backend_address_pool_ids = [module.app-gw.backend_address_pool[0]]
      load_balancer_backend_address_pool_ids       = []
      
    }
    "backend-vmss" = {
      subnet_id                                    = module.Network.subnet_ids["subnet3"]
      application_gateway_backend_address_pool_ids = []
      load_balancer_backend_address_pool_ids       = [module.lb["app"].lb_backend_address_pool]
      
    }
    "db-vmss" = {
      subnet_id                                    = module.Network.subnet_ids["subnet1"]
      application_gateway_backend_address_pool_ids = []
      load_balancer_backend_address_pool_ids       =  [module.lb["db"].lb_backend_address_pool]
    
    }
  }
}

module "vmss" {

  for_each                                     = local.vmss_info_map
  source                                       = "./modules/vmss"
  resource_group_name                          = var.resource_group_name
  location                                     = var.location
  vmss_name                                    = each.key
  vmss_sku                                     = var.vmss_sku
  username                                     = var.username
  key_path                                     = var.key_path
  custom_emails                                = var.custom_emails
  subnet_id                                    = each.value.subnet_id
  application_gateway_backend_address_pool_ids = each.value.application_gateway_backend_address_pool_ids
  load_balancer_backend_address_pool_ids       = each.value.load_balancer_backend_address_pool_ids
 
  


  depends_on = [azurerm_resource_group.rg]



}

locals {
  load_balancers = {
    "app" = {
      lb_name            = "LB-1"
      lb_subnet_id       = module.Network.subnet_ids["subnet2"] # For frontend/backend ILB
      backend_pool_name  = "LB-1-backend-pool"
      frontend_ip_config = "LB-1-frontend-ip"
    }
    "db" = {
      lb_name            = "LB-2"
      lb_subnet_id       = module.Network.subnet_ids["subnet1"] # For db-vmss ILB
      backend_pool_name  = "LB-2-backend-pool"
      frontend_ip_config = "LB-2-frontend-ip"
    }
  }
}

resource "azurerm_private_dns_a_record" "dns_records" {
  for_each            = module.lb
  name                = each.key
  ttl                 = 1
  resource_group_name = var.resource_group_name
  zone_name           = module.Network.dns_zone_name
  records             = [each.value.private_ip_address]
}

module "lb" {

  for_each             = local.load_balancers
  source               = "./modules/lb"
  resource_group_name  = var.resource_group_name
  location             = var.location
  lb_name              = each.value.lb_name
  lb_subnet_id         = each.value.lb_subnet_id
  backend_lb_pool_name = each.value.backend_pool_name
  lb_ip_config_name    = each.value.frontend_ip_config
  lb_sku               = var.lb_sku

  frontend_port = each.key == "db" ? 27017 : 80
  backend_port  = each.key == "db" ? 27017 : 80


  depends_on = [azurerm_resource_group.rg]
}

module "jumpbox" {
  source              = "./modules/jumpbox"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.Network.subnet_ids["subnet5"]
  username            = var.username
  key_path            = var.key_path
  jumpbox_pip_name = "Jumpbox-pip"
  
depends_on = [azurerm_resource_group.rg]
}

