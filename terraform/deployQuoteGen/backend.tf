#Use a remote backend from what we made in the s3 root module
terraform {
  backend "s3" {
    bucket         = "deploy-supergoon-kjb"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"    
    dynamodb_table = "deploy-locks"
    encrypt        = true
  }
}