resource "kubernetes_service" "k8s_service" {
  metadata {
    name = "${var.deploymentName}-service"
  }
  spec {
    selector = {
      app = var.deploymentName
    }
    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}