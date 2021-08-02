# Grab the module from the terraform registry to create the VPC with the following settings
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "kjb-vpc"
  cidr                 = "10.10.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.10.10.0/24", "10.10.12.0/24", "10.10.13.0/24"]
  public_subnets       = ["10.10.14.0/24", "10.10.15.0/24", "10.10.16.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
