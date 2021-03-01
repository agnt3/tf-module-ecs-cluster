provider "aws" {
  region = "sa-east-1"
}

terraform {
  required_version = ">= 0.12.9"
  backend "s3" {
    bucket = "agnt3-terraform-cluster-state"
  }
}