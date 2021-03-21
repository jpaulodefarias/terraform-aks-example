resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "scalable-wordpress-example"
    labels = {
      App = "ScalablewordpressExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalablewordpressExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalablewordpressExample"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8" #wordpress:5.6
          name  = "example"

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
    name = "wordpress-example"
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
