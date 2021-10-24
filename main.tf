module "transit_gateway" {
  source = "./modules/transit_gateway"

  stack_prefix = local.hdr_prefix
}

module "hub_network" {
  source = "./modules/network"

  stack_prefix = local.hdr_prefix
  region       = var.region

  vpc            = var.heimdallr.vpc
  subnet_public  = var.heimdallr.subnets.public
  subnet_private = var.heimdallr.subnets.private
  subnet_edge    = var.heimdallr.subnets.edge
}
