# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   config_context = "gke_${var.cluster_name}_${var.zone}_${var.project_id}"
# }
#
# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#     config_context = "gke_${var.cluster_name}_${var.zone}_${var.project_id}"
#   }
# }

resource "kubernetes_secret" "kube_vault_secrets" {
  metadata {
    name      = "kube-vault-secrets"
    namespace = "default"
  }
  data = {
    POSTGRES_DB       = var.vault_secrets["POSTGRES_DB"]
    POSTGRES_USER     = var.vault_secrets["POSTGRES_USER"]
    POSTGRES_PASSWORD = var.vault_secrets["POSTGRES_PASSWORD"]
    POSTGRES_HOST     = var.vault_secrets["POSTGRES_HOST"]
    POSTGRES_PORT     = var.vault_secrets["POSTGRES_PORT"]
    SECRET_KEY        = var.vault_secrets["SECRET_KEY"]
    WEB_ADDRESS       = var.vault_secrets["WEB_ADDRESS"]
  }
}

resource "kubernetes_secret" "dockerhub_cfg" {
  metadata {
    name = "dockerhub-cfg"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          "username" = var.vault_secrets["DOCKERHUB_USERNAME"]
          "password" = var.vault_secrets["DOCKERHUB_PASSWORD"]
          "email"    = var.vault_secrets["DOCKERHUB_EMAIL"]
          "auth" = base64encode("${var.vault_secrets["DOCKERHUB_USERNAME"]}:${var.vault_secrets["DOCKERHUB_PASSWORD"]}")
        }
      }
    })
  }
}

resource "kubernetes_secret" "github_packages_cfg" {
  metadata {
    name = "github-packages-cfg"
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://ghcr.io" = {
          "username" = var.vault_secrets["GITHUB_USERNAME"]
          "password" = var.vault_secrets["GITHUB_TOKEN"]
          "email"    = var.vault_secrets["GITHUB_EMAIL"]
          "auth"     = base64encode("${var.vault_secrets["GITHUB_USERNAME"]}:${var.vault_secrets["GITHUB_TOKEN"]}")
        }
      }
    })
  }
}

# resource "random_id" "bucket_prefix" {
#   byte_length = 8
# }

resource "google_storage_bucket" "static" {
  name          = "mysite-static-bucket"
  location      = var.region
  uniform_bucket_level_access = true
  versioning {
    enabled = false
  }
  cors {
    origin = ["https://${var.vault_secrets["DOMAIN"]}"]
  }
}

resource "google_storage_bucket" "media" {
  name          = "mysite-media-bucket"
  location      = var.region
#   force_destroy = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  cors {
    origin = ["https://${var.vault_secrets["DOMAIN"]}"]
  }
    public_access_prevention = "inherited"
}

resource "google_service_account" "app_bucket" {
  account_id   = "app-bucket"
}

resource "google_storage_bucket_iam_member" "static" {
  depends_on = [google_storage_bucket.static]
  bucket = google_storage_bucket.static.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.app_bucket.email}"
}

resource "google_storage_bucket_iam_member" "static_public_access" {
  bucket = google_storage_bucket.static.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "media" {
  depends_on = [google_storage_bucket.media]
  bucket = google_storage_bucket.media.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.app_bucket.email}"
}

resource "google_storage_bucket_iam_member" "media_public_access" {
  bucket = google_storage_bucket.media.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "kubernetes_service_account" "app_bucket" {
  metadata {
    name      = "app-bucket"
    namespace = "default"
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.app_bucket.email
    }
  }
}

resource "google_project_iam_member" "kube_workload_identity_member" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[default/app-bucket]"
}


resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  set {
    name  = "auth.username"
    value = var.vault_secrets["POSTGRES_USER"]
  }
  set {
    name  = "auth.password"
    value = var.vault_secrets["POSTGRES_PASSWORD"]
  }
  set {
    name  = "auth.database"
    value = var.vault_secrets["POSTGRES_DB"]
  }
}
