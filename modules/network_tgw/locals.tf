locals {
  is_hub       = (data.aws_caller_identity.default.account_id == data.aws_caller_identity.hub.account_id) ? true : false
  target_cidrs = [for cidr in var.system_cidrs : cidr if cidr != var.vpc.cidr]
}
