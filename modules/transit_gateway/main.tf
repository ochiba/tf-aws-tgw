# Create Transit Gateway
resource "aws_ec2_transit_gateway" "main" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  auto_accept_shared_attachments  = "disable"
  vpn_ecmp_support                = "enable"
  dns_support                     = "disable"

  tags = { Name = "${var.stack_prefix}-tgw" }
}

# Create RAM for Transit Gateway
resource "aws_ram_resource_share" "tgw" {
  name                      = "${var.stack_prefix}-ram-tgw"
  allow_external_principals = true

  tags = { Name = "${var.stack_prefix}-ram-tgw" }
}

resource "aws_ram_resource_association" "tgw" {
  resource_arn       = aws_ec2_transit_gateway.main.arn
  resource_share_arn = aws_ram_resource_share.tgw.arn
}

# Create Route Table for Transit Gateway
resource "aws_ec2_transit_gateway_route_table" "hub" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = { Name = "${var.stack_prefix}-tgw_rtbl-hub" }
  depends_on = [
    aws_ec2_transit_gateway.main
  ]
}

resource "aws_ec2_transit_gateway_route_table" "spoke" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = { Name = "${var.stack_prefix}-tgw_rtbl-spoke" }
  depends_on = [
    aws_ec2_transit_gateway.main
  ]
}
