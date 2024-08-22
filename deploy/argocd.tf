resource "helm_release" "argocd" {
  depends_on = [module.cluster]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
}

data "kubernetes_secret" "argocd_admin_password" {
  depends_on = [helm_release.argocd]
  metadata {
    name      = "argocd-initial-admin-secret"
  }
  binary_data = {
    "password" = ""
  }
}

# terraform {
#   required_providers {
#     argocd = {
#       source = "oboukili/argocd"
#     }
#   }
# }

provider "argocd" {
  server_addr = "argocd.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}:443"
  username    = "admin"
  password    = base64decode(data.kubernetes_secret.argocd_admin_password.binary_data["password"])
}

resource "argocd_application" "django_app" {
  depends_on = [data.kubernetes_secret.argocd_admin_password]
#   provider = argocd
  metadata {
    name      = "django-app"
  }
  cascade = false # disable cascading deletion
  wait    = true
  spec {
    destination {
      server    = "https://kubernetes.default.svc"
    }
    source {
      repo_url  = "https://github.com/alex-shef/mysite.git"
      path = "deploy/app"
      directory {
        recurse = false
      }
    }
    sync_policy {
      automated {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      retry {
        limit = "5"
        backoff {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
}
