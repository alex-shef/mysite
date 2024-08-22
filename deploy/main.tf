variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "gke_num_nodes" {
  description = "number of gke nodes"
}

variable "vault_app" {
  description = "vault app name"
}


# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   config_context = "gke_${module.cluster.cluster_name}_${var.zone}_${var.project_id}"
# }
#
# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#     config_context = "gke_${module.cluster.cluster_name}_${var.zone}_${var.project_id}"
#   }
# }

terraform {
  required_providers {
    argocd = {
      source = "oboukili/argocd"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
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

resource "google_project_service" "mysite" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

module "cluster" {
  depends_on = [google_project_service.mysite]
  source = "./cluster"
  gke_num_nodes = var.gke_num_nodes
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
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

module "app" {
  depends_on = [module.cluster]
  source = "./app"
#   cluster_name = module.main.cluster_name
  project_id = var.project_id
  region     = var.region
#   zone       = var.zone
  vault_secrets = data.hcp_vault_secrets_app.vault_secrets.secrets
}

module "services" {
  depends_on = [module.cluster]
  source = "./services"
#   cluster_name = module.cluster.cluster_name
  project_id = var.project_id
  region     = var.region
#   zone       = var.zone
  vault_secrets = data.hcp_vault_secrets_app.vault_secrets.secrets
#   kube_host = data.google_container_cluster.primary.endpoint
#   kube_token = data.google_client_config.current.access_token
#   kube_cert = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}
