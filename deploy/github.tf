provider "github" {
  token = data.hcp_vault_secrets_app.vault_secrets.secrets["GITHUB_TOKEN"]
}

resource "github_repository" "mysite" {
  name = var.repository_name
  description = "The blog on Django(Python3) deployed on GCP(GKE)"
  has_issues = true
  vulnerability_alerts = true
}

resource "github_repository_webhook" "mysite" {
  repository = github_repository.mysite.name

  configuration {
    url          = "https://jenkins.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}/github-webhook/"
    content_type = "form"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}
