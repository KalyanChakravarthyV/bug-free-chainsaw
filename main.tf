terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "KV_Terraform"

    workspaces {
      name = "bug-free-chainsaw"
    }
  }
}

  
provider "aws" {
  region  = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

/*
    Modules
*/
module "lambda" {
  source = "./lambda"
  count = 0
}
