resource "aws_route" "public_to_tgw" {
  for_each = {
    for x in setproduct(var.route_table_ids.public, local.target_cidrs) :
    join(",", x) => x
  }

  route_table_id         = each.value[0]
  destination_cidr_block = each.value[1]
  transit_gateway_id     = data.aws_ec2_transit_gateway.main.id

  depends_on = [
    time_sleep.wait_for_tgw_attachment
  ]
}

resource "aws_route" "private_to_tgw" {
  for_each = {
    for x in setproduct(var.route_table_ids.private, local.target_cidrs) :
    join(",", x) => x
  }

  route_table_id         = each.value[0]
  destination_cidr_block = each.value[1]
  transit_gateway_id     = data.aws_ec2_transit_gateway.main.id

  depends_on = [
    time_sleep.wait_for_tgw_attachment
  ]
}
