resource "azurerm_container_registry" "acr" {
  name                     = "containerregistrywordpress"
  resource_group_name      = azurerm_resource_group.wordpress.name
  location                 = azurerm_resource_group.wordpress.location
  sku                      = "Basic"
  admin_enabled            = true
}

data "azurerm_subscription" "current" {
}

#resource "azurerm_role_assignment" "acr_pull" {
 # principal_id   = azurerm_kubernetes_cluster.wordpress.identity[0].principal_id
 # role_definition_name = "AcrPull"
 # scope                  = azurerm_container_registry.acr.id
#}
