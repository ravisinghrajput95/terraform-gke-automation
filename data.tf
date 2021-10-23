data "google_client_config" "default" {}

data "google_container_cluster" "cluuster" {
  name = module.gke-cluster.name
  location = var.region
}
