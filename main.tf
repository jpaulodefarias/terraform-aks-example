terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.51"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">=1.4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.3"
    }
  }
}

provider "azurerm" {

	features {}

 subscription_id = var.subscriptionId

 client_id = var.clientID

 client_secret = var.clientSecret

 tenant_id = var.tenantID

}

provider "azuread" {}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.wordpress.kube_config.0.host
  client_key             = base64decode(azurerm_kubernetes_cluster.wordpress.kube_config.0.client_key)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.wordpress.kube_config.0.client_certificate)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.wordpress.kube_config.0.cluster_ca_certificate)
}
