provider "aws" {
    region = var.region
}

terraform {
    required_version = ">= 0.12.0"
    backend "s3" {
        region  = "ap-northeast-1"
        bucket  = "test-terraform-canary041x"
        key     = "terraform.tfstate"
        encrypt = true
    }
}