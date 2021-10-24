data "aws_vpc" "main" {
  id = var.vpc.id
}

resource "aws_subnet" "public" {
  count = length(var.subnet_public)

  vpc_id            = data.aws_vpc.main.id
  availability_zone = "${var.region.name}${var.subnet_public[count.index].az}"
  cidr_block        = var.subnet_public[count.index].cidr

  tags = {
    Name = "${var.stack_prefix}-sbn-public_${var.subnet_public[count.index].az}-${format("%02d", floor(count.index / 2) + 1)}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private" {
  count = length(var.subnet_private)

  vpc_id            = data.aws_vpc.main.id
  availability_zone = "${var.region.name}${var.subnet_private[count.index].az}"
  cidr_block        = var.subnet_private[count.index].cidr

  tags = {
    Name = "${var.stack_prefix}-sbn-private_${var.subnet_private[count.index].az}-${format("%02d", floor(count.index / 2) + 1)}"
    Tier = "Private"
  }
}

resource "aws_subnet" "edge" {
  count = length(var.subnet_edge)

  vpc_id            = data.aws_vpc.main.id
  availability_zone = "${var.region.name}${var.subnet_edge[count.index].az}"
  cidr_block        = var.subnet_edge[count.index].cidr

  tags = {
    Name = "${var.stack_prefix}-sbn-edge_${var.subnet_edge[count.index].az}-${format("%02d", floor(count.index / 2) + 1)}"
    Tier = "Edge"
  }
}
