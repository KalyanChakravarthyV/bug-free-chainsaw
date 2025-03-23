/*
    Variables
*/

variable "AWS_ACCESS_KEY_ID"  {}
variable "AWS_SECRET_ACCESS_KEY"  {}
variable "AWS_REGION"      {}

/*
    keys
*/
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
