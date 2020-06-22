# S3 Backend - Values must be hard coded.
terraform {
  backend "s3" {
    bucket  = "Placeholder"
    key     = "Placeholder"
    region  = "us-east-1"
    encrypt = true
  }
}
