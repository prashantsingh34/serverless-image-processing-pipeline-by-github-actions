terraform {
  required_version = "1.12.1"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.7.1"
    }
  }
  backend "s3" {
    region = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
}