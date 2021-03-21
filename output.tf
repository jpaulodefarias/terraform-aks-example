# output "client_key" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.client_key
# }

# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.client_certificate
# }

# output "cluster_ca_certificate" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.cluster_ca_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config_raw
# }

# output "host" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.host
# }

# output "cluster_username" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.username
# }

# output "cluster_password" {
#   value = azurerm_kubernetes_cluster.wordpress.kube_config.0.password
# }

# output "azurerm_mysql_server" {
#   value = azurerm_mysql_server.wordpress
# }

# output "azurerm_mysql_database" {
#   value = azurerm_mysql_database.wordpress
# }

output "ip" {
  value = kubernetes_service.wordpress.status.0.load_balancer.0.ingress.0.ip
}
