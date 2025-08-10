variable "resource_group_name" {
  type = string

}

variable "location" {
  type = string
}

#Network
variable "vnet_name" {
  type = string

}

variable "address_space" {
  type = list(string)

}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "dns_zone_name" {
  type = string
}

variable "dns_vnet_link_name" {

}
variable "nsg_name" {
  type = list(string)
}

#ACR
variable "acr_name" {
  type = string

}

variable "acr_sku" {
  type = string
}

#Application Gateway
variable "appgw_name" {
  type = string
}

variable "pip_name" {
  type = string

}

variable "frontend_ip_configuration_name" {
  type = string
}

variable "backend_address_pool_name" {
  type = string
}

variable "gateway_ip_configuration_name" {
  type = string
}

variable "frontend_port_name" {
  type = string
}

variable "http_listener_name" {
  type = string
}

variable "backend_http_settings_name" {
  type = string
}

variable "request_routing_rule_name" {
  type = string
}

#VMSS
variable "username" {
  type = string
}
variable "key_path" {
  type = string
}
variable "vmss_sku" {
  type = string
}

variable "custom_emails" {
  type = list(string)
}

#Load Balancer
variable "lb_name" {
  type = string
}
variable "lb_ip_config_name" {
  type = string
}

variable "lb_sku" {
  type = string
}
variable "backend_lb_pool_name" {
  type = string
}

