terraform {
  required_version = ">= 0.13.6"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.10.0"
    }
  }
}
    provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "my-context"
}
