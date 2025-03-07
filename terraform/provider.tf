terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }

  backend "kubernetes" {
    secret_suffix    = "paircoded-base-infra"
    config_path      = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
