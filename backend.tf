terraform {
  backend "s3" {
    bucket = "terraform-challenge-project"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_endpoint = "tf_table"
  }
}