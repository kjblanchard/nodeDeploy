variable "region" {
  default     = "us-east-2"
  description = "My AWS region"
}
# Assign a value to a local so that we can repeat it for all the tags.  You could use locals if you are gathering some logic for creating the variable, but this one is simple
locals {
  cluster_name = "kjbs-test-cluster"
}