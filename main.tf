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

module "spoke1_network" {
  source = "./modules/network"
  providers = {
    aws     = aws.spoke1
    aws.hub = aws
  }

  stack_prefix        = local.trs_prefix
  region              = var.region
  system_cidrs        = var.system_cidrs
  vpc                 = var.trista.vpc
  subnet_public       = var.trista.subnets.public
  subnet_private      = var.trista.subnets.private
  subnet_edge         = var.trista.subnets.edge
  tgw_id              = module.transit_gateway.tgw_id
  tgw_ram_name        = module.transit_gateway.tgw_ram_name
  tgw_route_table_ids = module.transit_gateway.tgw_route_table_ids

  depends_on = [
    module.transit_gateway
  ]
}

module "spoke1_demo_ec2" {
  source = "./modules/demo_ec2"
  providers = {
    aws = aws.spoke1
  }

  stack_prefix = local.trs_prefix
  region       = var.region
  vpc          = var.trista.vpc
  subnet_ids   = module.spoke1_network.subnet_ids
}

module "spoke2_network" {
  source = "./modules/network"
  providers = {
    aws     = aws.spoke2
    aws.hub = aws
  }

  stack_prefix        = local.lvs_prefix
  region              = var.region
  system_cidrs        = var.system_cidrs
  vpc                 = var.leeves.vpc
  subnet_public       = var.leeves.subnets.public
  subnet_private      = var.leeves.subnets.private
  subnet_edge         = var.leeves.subnets.edge
  tgw_id              = module.transit_gateway.tgw_id
  tgw_ram_name        = module.transit_gateway.tgw_ram_name
  tgw_route_table_ids = module.transit_gateway.tgw_route_table_ids

  depends_on = [
    module.transit_gateway
  ]
}

module "spoke2_demo_ec2" {
  source = "./modules/demo_ec2"
  providers = {
    aws = aws.spoke2
  }

  stack_prefix = local.lvs_prefix
  region       = var.region
  vpc          = var.leeves.vpc
  subnet_ids   = module.spoke2_network.subnet_ids
}
