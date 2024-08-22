# provider "kubernetes" {
#   host  = "https://${var.kube_host}"
#   token = var.kube_token
#   cluster_ca_certificate = var.kube_cert
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "gke-gcloud-auth-plugin"
#   }
# }
#
# provider "helm" {
#   kubernetes {
#     host  = "https://${var.kube_host}"
#     token = var.kube_token
#     cluster_ca_certificate = var.kube_cert
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "gke-gcloud-auth-plugin"
#     }
#   }
# }

resource "kubernetes_secret" "jenkins_dockerhub_usr_psw" {
  metadata {
    name = "jenkins-dockerhub-usr-psw"
    labels = {
      "jenkins.io/credentials-type" = "usernamePassword"
    }
    annotations = {
      "jenkins.io/credentials-description"  = "credentials from Kubernetes"
    }
  }
  type = "Opaque"
  data = {
    username = var.vault_secrets["DOCKERHUB_USERNAME"]
    password = var.vault_secrets["DOCKERHUB_PASSWORD"]
  }
}

resource "kubernetes_secret" "jenkins_github_usr_psw" {
  metadata {
    name = "jenkins-github-usr-psw"
    labels = {
      "jenkins.io/credentials-type" = "usernamePassword"
    }
    annotations = {
      "jenkins.io/credentials-description"  = "credentials from Kubernetes"
    }
  }
  type = "Opaque"
  data = {
    username = var.vault_secrets["GITHUB_USERNAME"]
    password = var.vault_secrets["GITHUB_TOKEN"]
  }
}

resource "kubernetes_secret" "jenkins_database_usr_psw" {
  metadata {
    name = "jenkins-database-usr-psw"
    labels = {
      "jenkins.io/credentials-type" = "usernamePassword"
    }
    annotations = {
      "jenkins.io/credentials-description"  = "credentials from Kubernetes"
    }
  }
  type = "Opaque"
  data = {
    username = var.vault_secrets["POSTGRES_USER"]
    password = var.vault_secrets["POSTGRES_PASSWORD"]
  }
}

resource "kubernetes_secret" "jenkins_django_secretkey" {
  metadata {
    name = "jenkins-django-secretkey"
    labels = {
      "jenkins.io/credentials-type" = "secretText"
    }
    annotations = {
      "jenkins.io/credentials-description"  = "secret text credential from Kubernetes"
    }
  }
  type = "Opaque"
  data = {
    text = var.vault_secrets["SECRET_KEY"]
  }
}

# resource "random_id" "bucket_prefix" {
#   byte_length = 8
# }

resource "google_storage_bucket" "loki_logs" {
  name          = "${var.project_id}-loki-logs-bucket"
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
#   lifecycle_rule {
#     action {
#       type = "Delete"
#     }
#     condition {
#       age = 2
#     }
#   }
  public_access_prevention = "inherited"
}

resource "google_service_account" "loki" {
  account_id   = "loki-gsa"
}

resource "google_storage_bucket_iam_member" "loki" {
  depends_on = [google_storage_bucket.loki_logs]
  bucket = google_storage_bucket.loki_logs.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.loki.email}"
}

resource "google_project_iam_member" "loki_workload_identity_binding" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[loki/loki]"
}
