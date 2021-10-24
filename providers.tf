terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Common
provider "aws" {
  region  = var.region.name
  profile = "heimdallr"

  default_tags {
    tags = local.hdr_tags
  }
}

data "aws_caller_identity" "default" {}
