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

/* Modules
*/

module "lambda"{
    source = "./lambda"
    count = 1
}