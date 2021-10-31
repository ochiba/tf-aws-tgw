resource "aws_vpc_endpoint" "ssm" {
  service_name        = "com.amazonaws.${var.region.name}.ssm"
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc.id
  subnet_ids          = var.subnet_ids.edge
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  service_name        = "com.amazonaws.${var.region.name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc.id
  subnet_ids          = var.subnet_ids.edge
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]
}

resource "aws_vpc_endpoint" "ec2messages" {
  service_name        = "com.amazonaws.${var.region.name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc.id
  subnet_ids          = var.subnet_ids.edge
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.vpce.id]
}
