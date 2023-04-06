resource "azurerm_resource_group" "wordpress" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "wordpress" {
  name                       = var.cluster_name
  location                   = azurerm_resource_group.wordpress.location
  resource_group_name        = azurerm_resource_group.wordpress.name
  dns_prefix                 = var.dns_prefix
  enable_pod_security_policy = false
  role_based_access_control {
    enabled = true
  }
  
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  service_principal {
    client_id     = azuread_service_principal.wordpress.application_id
    client_secret = azuread_service_principal_password.wordpress.value
  }


  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.1.0.10"
    service_cidr      = "10.1.0.0/16"
  }
  
 

  tags = {
    Environment = "Development"
  }
}
