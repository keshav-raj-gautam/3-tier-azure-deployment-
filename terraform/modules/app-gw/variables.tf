variable "vnet_name" {
  type = string
}
variable "location"{
    type = string
}

variable "resource_group_name"{
    type = string
}

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

variable "gw_subnet_id" {
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