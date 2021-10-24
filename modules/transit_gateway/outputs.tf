output "tgw_id" {
  value = aws_ec2_transit_gateway.main.id
}

output "tgw_ram_name" {
  value = aws_ram_resource_share.tgw.name
}

output "tgw_route_tables" {
  value = {
    hub   = aws_ec2_transit_gateway_route_table.hub
    spoke = aws_ec2_transit_gateway_route_table.spoke
  }
}
