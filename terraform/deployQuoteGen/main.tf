provider "aws" {
  region = "us-east-2"
}

#Use our module in the modules folder to build this, and set all the input variables to below.
#Keep enable_r53 to false, I was using this to update my route53 record to the ELB so I could access it
module "webserver_cluster" {
  source = "../modules/deployments"
  image_id = "enf3rno/quotegenerator:latest"
  min_replicas = 2
  max_replicas = 5
  cpu_scale_threshold = 50
  deploymentName = "quotegen"
  websiteDnsName = "kubernetes"
  enable_r53 = false
}