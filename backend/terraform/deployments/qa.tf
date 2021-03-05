variable "company_name" {
  default = "company"
}

variable "region_name" {
  default = "eu-west-2"
}

variable "env_name" {
  default = "qa"
}

variable "s3_private_bucket_name" {
  default = "qa-data"
}

variable "s3_public_bucket_name"  {
  default = "qa-pub"
}

variable "s3_bo_bucket_name"  {
  default = "qa-bo"
}

variable "s3_fo_bucket_name"  {
  default = "qa-fo"
}

provider "aws" {
  profile    = var.env_name
  region     = var.region_name
}

terraform {
  backend "s3" {
    bucket = "quicksite-qa-terraform-state"
    key = "quicksite-qa.tfstate"
    region = "eu-west-2"
    dynamodb_table = "quiksite-qa-terraform-locks"
    encrypt = false
  }
}
