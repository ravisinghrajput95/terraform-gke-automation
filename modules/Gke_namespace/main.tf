resource "kubernetes_namespace" "test" {
  metadata {
    annotations = {
      name = "test"
    }

    labels = {
      mylabel = "test"
    }

    name = "test"
  }
}
