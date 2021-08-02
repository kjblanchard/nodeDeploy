#Creates the kubernetes deployment of the actual thing we are deploying, left it generic as this module should be used for any deployment until a helm chart is created for it
#Use replicas of 1 as we are using a horizontal pod scaler to scale it up and it will override this, it is optional but left it anyways
resource "kubernetes_deployment" "k8s_deployment" {
  metadata {
    name = "${var.deploymentName}-deployment"
    labels = {
      name = "${var.deploymentName}-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${var.deploymentName}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.deploymentName}"
        }
      }

      spec {
        container {
          image = var.image_id
          name  = "${var.deploymentName}"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}