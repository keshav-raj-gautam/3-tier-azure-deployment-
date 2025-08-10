variable "vnet_name" {
  type = string
}
variable "location"{
    type = string
}

variable "address_space" {
  type = list(string)
}

variable "resource_group_name"{
    type = string
}

variable "subnets" {
    type = map(object({
      name =  string
      address_prefixes= list(string)
    }))
  
}
variable "dns_zone_name" {
  type = string
}

variable "dns_vnet_link_name" {
  
}
