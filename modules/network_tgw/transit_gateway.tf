# Transit Gatewayの共有（Cross Accountでのみ必要）
# Transit Gateway用RAMをTarget Accountに紐付けてTarget Accountで受諾する。
data "aws_ram_resource_share" "tgw" {
  count    = local.is_hub ? 0 : 1
  provider = aws.hub

  name           = var.tgw_ram_name
  resource_owner = "SELF"
}

resource "aws_ram_principal_association" "tgw" {
  count    = local.is_hub ? 0 : 1
  provider = aws.hub

  principal          = data.aws_caller_identity.default.account_id
  resource_share_arn = data.aws_ram_resource_share.tgw[0].arn
}

resource "aws_ram_resource_share_accepter" "tgw" {
  count = local.is_hub ? 0 : 1

  share_arn = aws_ram_principal_association.tgw[0].resource_share_arn
}

# Transit Gateway Attachmentの作成
# Target VPCでAttachmentを作成後、Transit Gatewayの所有者が受諾する。
data "aws_ec2_transit_gateway" "main" {
  provider = aws.hub

  id = var.tgw_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  transit_gateway_id                              = data.aws_ec2_transit_gateway.main.id
  vpc_id                                          = var.vpc.id
  subnet_ids                                      = var.subnet_ids.edge
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  dns_support                                     = "disable"

  tags = { Name = "${var.stack_prefix}-tgw_attach" }
  depends_on = [
    aws_ram_resource_share_accepter.tgw
  ]
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "main" {
  count    = local.is_hub ? 0 : 1
  provider = aws.hub

  transit_gateway_attachment_id                   = aws_ec2_transit_gateway_vpc_attachment.main.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.main
  ]
}

# Transit Gateway AttachmentへのRoute Tableの紐付け
resource "time_sleep" "wait_for_tgw_attachment" {
  create_duration = "30s"

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment_accepter.main
  ]
}

resource "aws_ec2_transit_gateway_route_table_association" "main" {
  provider = aws.hub

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main.id
  transit_gateway_route_table_id = local.is_hub ? var.tgw_route_table_ids.hub : var.tgw_route_table_ids.spoke

  depends_on = [
    time_sleep.wait_for_tgw_attachment
  ]
}

# 通信先のTransit Gateway Attachmentに紐づくRoute TableへのRoute追加
data "aws_ec2_transit_gateway_route_table" "hub" {
  provider = aws.hub

  id = var.tgw_route_table_ids.hub
}

data "aws_ec2_transit_gateway_route_table" "spoke" {
  provider = aws.hub

  id = var.tgw_route_table_ids.spoke
}

# RouteTable@Hub: Target VPC -> Spoke attachment
resource "aws_ec2_transit_gateway_route" "vpc_to_hub_attachment" {
  count    = local.is_hub ? 0 : 1
  provider = aws.hub

  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.hub.id
  destination_cidr_block         = var.vpc.cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main.id

  depends_on = [
    time_sleep.wait_for_tgw_attachment
  ]
}

# RouteTable@Spoke: Target VPC -> Hub attachment
resource "aws_ec2_transit_gateway_route" "vpc_to_spoke_attachment" {
  count    = local.is_hub ? 1 : 0
  provider = aws.hub

  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.spoke.id
  destination_cidr_block         = var.vpc.cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main.id

  depends_on = [
    time_sleep.wait_for_tgw_attachment
  ]
}
