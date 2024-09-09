variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "vault_app" {
  description = "vault app name"
}

variable "repository_name" {
  description = "github repository name"
}

terraform {
  required_providers {
    argocd = {
      source = "oboukili/argocd"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
    github = {
      source  = "integrations/github"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "hcp" {}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.primary.endpoint}"
  token = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.primary.endpoint}"
    token = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}

data "hcp_vault_secrets_app" "vault_secrets" {
  app_name = var.vault_app
}

data "google_client_config" "current" {}

data "google_container_cluster" "primary" {
  depends_on = [google_project_service.mysite]
  name = module.cluster.cluster_name
  location = var.zone
}

resource "google_project_service" "mysite" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

module "cluster" {
  depends_on = [google_project_service.mysite]
  source = "./cluster"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}

module "app" {
  depends_on = [module.cluster]
  source = "./app"
#   cluster_name = module.main.cluster_name
  project_id = var.project_id
  region     = var.region
  vault_secrets = data.hcp_vault_secrets_app.vault_secrets.secrets
  repository_name = var.repository_name
}

module "services" {
  depends_on = [module.cluster]
  source = "./services"
#   cluster_name = module.cluster.cluster_name
  project_id = var.project_id
  region     = var.region
  vault_secrets = data.hcp_vault_secrets_app.vault_secrets.secrets
}
