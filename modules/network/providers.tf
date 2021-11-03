terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 3.0"
      configuration_aliases = [aws.hub]
    }
  }
}

data "aws_caller_identity" "default" {}
data "aws_caller_identity" "hub" { provider = aws.hub }
