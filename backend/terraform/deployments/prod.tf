variable "company_name" {
  default = "company"
}

variable "region_name" {
  default = "eu-west-2"
}

variable "env_name" {
  default = "prod"
}

variable "s3_private_bucket_name" {
  default = "prod-data"
}

variable "s3_public_bucket_name"  {
  default = "prod-pub"
}

variable "s3_bo_bucket_name"  {
  default = "prod-bo"
}

variable "s3_fo_bucket_name"  {
  default = "prod-fo"
}

provider "aws" {
  profile    = var.env_name
  region     = var.region_name
}

terraform {
  backend "s3" {
    bucket = "quicksite-prod-terraform-state"
    key = "quicksite-prod.tfstate"
    region = "eu-west-2"
    dynamodb_table = "quiksite-prod-terraform-locks"
    encrypt = false
  }
}
