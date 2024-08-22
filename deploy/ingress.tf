resource "helm_release" "ingress-nginx" {
  depends_on = [module.services]
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }
  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
}

resource "helm_release" "cert_manager" {
  depends_on = [module.services]
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name  = "crds.enabled"
    value = "true"
  }
}

resource "kubectl_manifest" "letsencrypt_prod" {
  depends_on = [helm_release.cert_manager]
  yaml_body  = <<YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-prod
    spec:
      acme:
        server: https://acme-v02.api.letsencrypt.org/directory
        email: ${data.hcp_vault_secrets_app.vault_secrets.secrets["GITHUB_EMAIL"]}
        privateKeySecretRef:
          name: letsencrypt-prod
        solvers:
        - http01:
            ingress:
              class: nginx
    YAML
}

resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [kubectl_manifest.letsencrypt_prod]

  metadata {
    name        = "ingress"
    annotations = {
      "cert-manager.io/cluster-issuer"             = "letsencrypt-prod"
      "kubernetes.io/tls-acme"                     = "true"
      "kubernetes.io/ingress.class"                = "nginx"
    }
  }

  spec {
    tls {
      hosts = [
        data.hcp_vault_secrets_app.vault_secrets.secrets["WEB_ADDRESS"],
        "jenkins.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}",
      ]
      secret_name = "main-tls-secret"
    }

    rule {
      host = data.hcp_vault_secrets_app.vault_secrets.secrets["WEB_ADDRESS"]
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "django-app"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    rule {
      host = "jenkins.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "jenkins"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "grafana_ingress" {
  depends_on = [kubectl_manifest.letsencrypt_prod]
  metadata {
    name        = "grafana-ingress"
    namespace   = "loki"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
      "kubernetes.io/tls-acme"         = "true"
      "kubernetes.io/ingress.class"    = "nginx"
    }
  }
  spec {
    tls {
      hosts = [
        "grafana.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}",
      ]
      secret_name = "main-tls-secret"
    }
    rule {
      host = "grafana.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "grafana"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "argocd_ingress" {
  depends_on = [kubectl_manifest.letsencrypt_prod]

  metadata {
    name        = "argocd-ingress"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
      "kubernetes.io/tls-acme" = "true"
      "cloud.google.com/neg" = "{'ingress': true}"
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    tls {
      hosts = ["argocd.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}"]
      secret_name = "argocd-secret"
    }
    rule {
      host = "argocd.${data.hcp_vault_secrets_app.vault_secrets.secrets["DOMAIN"]}"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "argocd-server"
              port {
                number = 443
              }
            }
          }
        }
      }
    }
  }
}
