variable "resource_group_name" {
  type = string

}

variable "location" {
  type = string
}

variable "lb_name" {
  type = string
}
variable "lb_ip_config_name" {
  type = string
}
variable "lb_subnet_id" {
    type = string
  
}
variable "lb_sku" {
  type = string
}
variable "backend_lb_pool_name" {
  type = string
}

variable "backend_port" {
  type = string
}

variable "frontend_port" {
  type = string
}
