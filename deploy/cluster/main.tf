# GKE cluster
data "google_container_engine_versions" "gke_versions" {}

data "google_client_config" "current" {}

resource "google_container_cluster" "primary" {
  deletion_protection = false
  name     = "mysite"
  location = var.zone

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  workload_identity_config {
      workload_pool = "${data.google_client_config.current.project}.svc.id.goog"
    }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  
  version = google_container_cluster.primary.master_version

  autoscaling {
    min_node_count = 2
    max_node_count = 6
  }

  node_config {

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", var.project_id]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
        mode = "GKE_METADATA"
      }
  }
  timeouts {
    create = "15m"
  }
#   lifecycle {
#     ignore_changes = [version]
#   }
}

resource "null_resource" "kubeconfig" {
  depends_on = [google_container_cluster.primary,
                google_container_node_pool.primary_nodes]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${var.zone} --project ${var.project_id}"
  }
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}
