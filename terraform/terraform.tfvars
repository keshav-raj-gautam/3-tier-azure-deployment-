
resource_group_name = "Bookstore-rg"
location            = "Central India"
vnet_name           = "Bookstore-vnet"

#Network 

address_space       = ["10.0.0.0/16"]
subnets = {
  subnet1 = {
    name             = "db-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "front-subnet"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name             = "back-subnet"
    address_prefixes = ["10.0.3.0/24"]
  }
  subnet4 = {
    name             = "app-gateway-subnet"
    address_prefixes = ["10.0.4.0/24"]
  }
  subnet5 = {
    name             = "jumpbox-subnet"
    address_prefixes = ["10.0.5.0/24"]
  }
}

nsg_name                       = ["db-nsg", "front-nsg", "back-nsg"]
dns_zone_name                  = "bookstore.com"
dns_vnet_link_name             = "vnet-link"

#ACR
acr_name                       = "Bookstoreacr"
acr_sku                        = "Basic"

#Application Gateway
appgw_name                     = "App-gw"
pip_name                       = "App-gw-pip"
backend_address_pool_name      = "frontend-vmss"
frontend_ip_configuration_name = "App-gw-frontend-ip-config"
request_routing_rule_name      = "Rule-1"
http_listener_name             = "app-gw-listener"
frontend_port_name             = "80"
gateway_ip_configuration_name  = "App-gw-ip-config"
backend_http_settings_name     = "app-gw-backend-settings"

#VMSS
vmss_sku = "Standard_F1s"
username = "keshav"
key_path = "./vmss-key.pub"
custom_emails = ["keshavrajgautam20@gmail.com"]

#Load Balancer
lb_name              = "InternalLB"
backend_lb_pool_name = "Backend-pool-for-LB"
lb_ip_config_name    = "LB-ip-config"
lb_sku               = "Basic"

