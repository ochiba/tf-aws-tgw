resource "aws_route" "public_to_tgw" {
  for_each = toset(local.target_cidrs)

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = each.value
  transit_gateway_id     = data.aws_ec2_transit_gateway.main.id

  depends_on = [
    aws_route_table.public,
    time_sleep.wait_for_tgw_attachment
  ]
}

resource "aws_route" "private_a_to_tgw" {
  for_each = toset(local.target_cidrs)

  route_table_id         = aws_route_table.private_a.id
  destination_cidr_block = each.value
  transit_gateway_id     = data.aws_ec2_transit_gateway.main.id

  depends_on = [
    aws_route_table.private_a,
    time_sleep.wait_for_tgw_attachment
  ]
}

resource "aws_route" "private_c_to_tgw" {
  for_each = toset(local.target_cidrs)

  route_table_id         = aws_route_table.private_c.id
  destination_cidr_block = each.value
  transit_gateway_id     = data.aws_ec2_transit_gateway.main.id

  depends_on = [
    aws_route_table.private_c,
    time_sleep.wait_for_tgw_attachment
  ]
}
