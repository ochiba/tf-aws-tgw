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

# System-A
provider "aws" {
  alias   = "spoke1"
  region  = var.region.name
  profile = "trista"

  default_tags {
    tags = local.trs_tags
  }
}

data "aws_caller_identity" "spoke_1" { provider = aws.spoke1 }
