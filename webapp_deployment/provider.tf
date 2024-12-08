# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "5.80.0"
#     }
#   }
# }

provider "aws" {
    region = var.region
    profile = var.profile
}