resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress"
    labels = {
      App = "wordpress"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          App = "wordpress"
        }
      }
      spec {
        container {
          image = "wordpress:5.6"
          name  = "wordpress"

          env {
            name = "WORDPRESS_DB_HOST"
            value = azurerm_mysql_server.wordpress.fqdn
          }

          env {
            name = "WORDPRESS_DB_NAME"
            value = azurerm_mysql_database.wordpress.name
          }
          env {
            name = "WORDPRESS_DB_USER"
            value = azurerm_mysql_server.wordpress.administrator_login
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"
            value = azurerm_mysql_server.wordpress.administrator_login_password
          }
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      App = kubernetes_deployment.wordpress.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
