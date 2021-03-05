variable "company_name" {
  default = "company"
}

variable "region_name" {
  default = "eu-west-2"
}

variable "env_name" {
  default = "dev"
}

variable "s3_private_bucket_name" {
  default = "dev-data"
}

variable "s3_public_bucket_name"  {
  default = "dev-pub"
}

variable "s3_bo_bucket_name"  {
  default = "dev-bo"
}

variable "s3_fo_bucket_name"  {
  default = "dev-fo"
}

provider "aws" {
  profile    = var.env_name
  region     = var.region_name
}

terraform {
  backend "s3" {
    bucket = "quicksite-dev-terraform-state"
    key = "quicksite-dev.tfstate"
    region = "eu-west-2"
    dynamodb_table = "quiksite-dev-terraform-locks"
    encrypt = false
  }
}
