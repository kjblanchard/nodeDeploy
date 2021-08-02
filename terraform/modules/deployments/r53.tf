resource "aws_route53_record" "k8s" {
  count = var.enable_r53 ? 1 : 0
  zone_id = "Z1033734GXUIGI0YW2PJ"
  name    = "${var.websiteDnsName}.supergoon.com"
  type    = "A"
  allow_overwrite = true
  alias {
    name                     = kubernetes_service.k8s_service.status.0.load_balancer.0.ingress.0.hostname
    zone_id                  = "Z3AADJGX6KTTL2"  
    evaluate_target_health   = true
  }
}