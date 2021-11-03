module "transit_gateway" {
  source = "./modules/transit_gateway"

  stack_prefix = local.hdr_prefix
}

module "hub_network" {
  source = "./modules/network"
  providers = {
    aws     = aws
    aws.hub = aws
  }

  stack_prefix        = local.hdr_prefix
  region              = var.region
  system_cidrs        = var.system_cidrs
  vpc                 = var.heimdallr.vpc
  subnet_public       = var.heimdallr.subnets.public
  subnet_private      = var.heimdallr.subnets.private
  subnet_edge         = var.heimdallr.subnets.edge
  is_hub              = true
  tgw_id              = module.transit_gateway.tgw_id
  tgw_ram_name        = module.transit_gateway.tgw_ram_name
  tgw_route_table_ids = module.transit_gateway.tgw_route_table_ids

  depends_on = [
    module.transit_gateway
  ]
}

module "hub_demo_ec2" {
  source = "./modules/demo_ec2"
  providers = {
    aws = aws
  }

  stack_prefix = local.hdr_prefix
  region       = var.region
  vpc          = var.heimdallr.vpc
  subnet_ids   = module.hub_network.subnet_ids
}
