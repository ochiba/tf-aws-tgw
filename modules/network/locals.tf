locals {
  target_cidrs = [for cidr in var.system_cidrs : cidr if cidr != var.vpc.cidr]
}
