output "hdr_subnet_ids" {
  value = module.hub_network.subnet_ids
}
output "hdr_route_table_id" {
  value = module.hub_network.route_table_id
}
output "hdr_ec2_ip" {
  value = module.hub_demo_ec2.private_ip
}

output "trs_subnet_ids" {
  value = module.spoke1_network.subnet_ids
}
output "trs_route_table_id" {
  value = module.spoke1_network.route_table_id
}
output "trs_ec2_ip" {
  value = module.spoke1_demo_ec2.private_ip
}
