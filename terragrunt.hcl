#generate "provider" {
#  path = "provider.tf"
#  if_exists = "overwrite_terragrunt"
#  contents = <<EOF
#  provider "aws" {
#     region  = "eu-west-1"
#     profile = "FDM-profile"
#  }
#  terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "2.57"
#    }
#}
# required_version = "~> 1.2.1"
#  backend "s3" {}
#  }
#EOF
#}


##without required_version##
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  provider "aws" {
     region  = "eu-west-1"
     profile = "FDM-profile"
  }
  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.57"
    }
}
  backend "s3" {}
  }
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt                 = true
    bucket                  = "fdm-backend-tut-bucket"
    key                     = "${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table          = "FDM-backend-lock-table"
    profile                 = "FDM-profile"
    region                  = "eu-west-1"
  }
}

inputs = {
  profile        = "FDM-profile"
  platform_name          = "fdm-platform"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]  # Default availability zones
  region = "eu-west-1"
}