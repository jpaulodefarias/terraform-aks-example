resource "azurerm_virtual_network" "wordpress_vnet" {
  name                = "wordpress-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
}

resource "azurerm_subnet" "appgateway" {
  name                 = "appgateway-subnet"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.wordpress.name
  virtual_network_name = azurerm_virtual_network.wordpress_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "appgateway" {
  name                = "appgateway-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "wordpress" {
  name                = "wordpress-appgateway"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name

    identity {
  type         = "UserAssigned"
  identity_ids = [azurerm_user_assigned_identity.identity.id]
  }

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "wordpress-gateway-ip-configuration"
    subnet_id = azurerm_subnet.appgateway.id
  }

  frontend_ip_configuration {
    name                 = "wordpress-frontend-ip-configuration"
    public_ip_address_id = azurerm_public_ip.appgateway.id
  }

  frontend_port {
    name = "wordpress-frontend-port"
    port = 80
  }

  backend_address_pool {
    name = "wordpress-backend-address-pool"
  }

  backend_http_settings {
    name                  = "wordpress-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "wordpress-http-listener"
    frontend_ip_configuration_name = "wordpress-frontend-ip-configuration"
    frontend_port_name             = "wordpress-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "wordpress-request-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "wordpress-http-listener"
    backend_address_pool_name  = "wordpress-backend-address-pool"
    backend_http_settings_name = "wordpress-backend-http-settings"
  }
}