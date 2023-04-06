resource "azurerm_user_assigned_identity" "identity" {
  name                = var.managed_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

#resource "azurerm_role_assignment" "aks" {
#  scope                = azurerm_kubernetes_cluster.wordpress.id
#  role_definition_name = "Azure Kubernetes Service Cluster User Role"
#  principal_id         = azurerm_user_assigned_identity.identity.principal_id
#}

#resource "azurerm_role_assignment" "acr_pull" {
#  scope                = azurerm_container_registry.acr.id
#  role_definition_name = "AcrPull"
#  principal_id         = azurerm_user_assigned_identity.identity.principal_id
#}

output "identity_client_id" {
  value = azurerm_user_assigned_identity.identity.client_id
}
