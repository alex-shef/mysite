resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"

  values = [
    file("${path.module}/jenkins-values.yaml")
  ]
}

resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
  }
}

resource "helm_release" "memcached_chunk_cache" {
  name       = "memcached-chunk-cache"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "memcached"
  namespace  = kubernetes_namespace.loki.metadata[0].name
  values = [
    yamlencode({
      command = ["memcached"]
      args = [
        "-I 2m",
        "-c 1024"
      ]
    })
  ]
}

resource "helm_release" "memcached_results_cache" {
  name       = "memcached-results-cache"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "memcached"
  namespace  = kubernetes_namespace.loki.metadata[0].name
  values = [
    yamlencode({
      command = ["memcached"]
      args = [
        "-I 5m",
        "-c 1024"
      ]
    })
  ]
}

resource "helm_release" "loki" {
  depends_on = [kubernetes_namespace.loki,
                helm_release.memcached_chunk_cache,
                helm_release.memcached_results_cache]
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  namespace  = kubernetes_namespace.loki.metadata[0].name

  values = [
    file("${path.module}/loki-values.yaml")
  ]
  set {
    name  = "loki.storage.bucketNames.chunks"
    value = google_storage_bucket.loki_logs.name
  }
  set {
    name  = "loki.storage.bucketNames.ruler"
    value = google_storage_bucket.loki_logs.name
  }
  set {
    name  = "loki.storageConfig.gcs.bucket_name"
    value = google_storage_bucket.loki_logs.name
  }
  set {
    name  = "serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
    value = "${google_service_account.loki.account_id}@${var.project_id}.iam.gserviceaccount.com"
    type  = "string"
  }
}

resource "helm_release" "grafana_alloy" {
  depends_on = [helm_release.loki]
  name       = "grafana-alloy"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  namespace  = kubernetes_namespace.loki.metadata[0].name
  values = [
    file("${path.module}/alloy-values.yaml")
  ]
}

resource "kubernetes_role" "cluster_events_viewer" {
  metadata {
    name      = "cluster-events-viewer"
    namespace = kubernetes_namespace.loki.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "cluster_events_viewer_binding" {
  depends_on = [helm_release.grafana_alloy]
  metadata {
    name      = "cluster-events-viewer-binding"
    namespace = kubernetes_namespace.loki.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.cluster_events_viewer.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = helm_release.grafana_alloy.name
    namespace = kubernetes_namespace.loki.metadata[0].name
  }
}

resource "kubernetes_config_map" "grafana_dashboard" {
  metadata {
    name = "grafana-dashboard"
    namespace = kubernetes_namespace.loki.metadata[0].name
  }
  data = {
    "grafana-dashboard.json" = file("${path.module}/dashboard.json")
  }
}

resource "helm_release" "grafana" {
  depends_on = [kubernetes_config_map.grafana_dashboard]
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.loki.metadata[0].name
  values = [
    file("${path.module}/grafana-values.yaml")
  ]
  set {
    name  = "alerting.contactpoints\\.yaml.secret.contactPoints[0].receivers[0].settings.url"
    value = var.vault_secrets["SLACK_WEBHOOK"]
    type  = "string"
  }
  set {
    name  = "grafana\\.ini.server.domain"
    value = "grafana.${var.vault_secrets["DOMAIN"]}"
  }
  set {
    name  = "grafana\\.ini.server.root_url"
    value = "https://grafana.${var.vault_secrets["DOMAIN"]}"
  }
}
