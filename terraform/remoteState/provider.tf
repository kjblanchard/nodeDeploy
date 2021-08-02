# Use the provider in our environment variables, and the regions set to our variables region
provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}