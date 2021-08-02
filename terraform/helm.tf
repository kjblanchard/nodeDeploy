resource "helm_release" "metrics_server_release" {
  name       = "kjb-metrics"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  version    = "5.9.0"

  set {
    name  = "apiService.create"
    value = "true"
  }

  depends_on = [
    module.eks
  ]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}