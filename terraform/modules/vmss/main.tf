locals {
  
}


resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  
  name = var.vmss_name
  resource_group_name = var.resource_group_name
  location = var.location
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  sku = var.vmss_sku
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  admin_username = var.username
  network_interface {
    primary = true
    name = "${var.vmss_name}-nic"
    ip_configuration {
      primary = true
     name = "${var.vmss_name}-ip-config"
     subnet_id = var.subnet_id

     application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids
     load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
     
    }
    
  }

admin_ssh_key {
 username = var.username
 public_key = file(var.key_path)
}
}

resource "azurerm_monitor_autoscale_setting" "vmss-as" {
  
  name = "${var.vmss_name}-autoscale"
  resource_group_name = var.resource_group_name
  location = var.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
  
  profile {
    name = "defaultProfile"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  predictive {
    scale_mode      = "Enabled"
    look_ahead_time = "PT5M"
  }

 

}

