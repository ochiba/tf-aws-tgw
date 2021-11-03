output "vpc" {
  value = module.hub_network.vpc
}
output "subnet_ids" {
  value = module.hub_network.subnet_ids
}
output "route_table_id" {
  value = module.hub_network.route_table_id
}

output "hdr_ec2_ip" {
  value = module.hub_demo_ec2.private_ip
}
