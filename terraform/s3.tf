#Create where we are storing the deployments state.  In a real world, I would store this module in remote state as well, but this reduces the amount of terraform inits and applys we need to do by not doing it.
resource "aws_s3_bucket" "terraform_state" {
  bucket = "deploy-supergoon-kjb" 
  force_destroy = true
  versioning {
    enabled = true
  }  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
#Create a way to lock the file out when someone is using it, so multiple people don't break terraform state
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "deploy-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"  
  attribute {
    name = "LockID"
    type = "S"
  }
}