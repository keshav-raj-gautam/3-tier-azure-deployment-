variable "resource_group_name" {
  type = string

}

variable "location" {
  type = string
}

variable "vmss_name" {
  type = string
}

variable "username" {
  type = string
}
variable "key_path" {
  type = string
}
variable "vmss_sku" {
  type = string
}
variable "application_gateway_backend_address_pool_ids" {
  type = list(string)

}
variable "load_balancer_backend_address_pool_ids" {
  type = list(string)
}


variable "custom_emails" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

