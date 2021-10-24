# Public subnet
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtb-public"
    Tier = "Public"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public
  ]
}

# Private subnet
resource "aws_route_table" "private" {
  count = 2

  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtb-private_${var.subnet_private[count.index].az}"
    Tier = "Private"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index % 2].id

  depends_on = [
    aws_subnet.private,
    aws_route_table.private
  ]
}

# Edge subnet
resource "aws_route_table" "edge" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtb-edge"
    Tier = "Edge"
  }
}

resource "aws_route_table_association" "edge" {
  count = length(aws_subnet.edge)

  subnet_id      = aws_subnet.edge[count.index].id
  route_table_id = aws_route_table.edge.id

  depends_on = [
    aws_subnet.edge,
    aws_route_table.edge
  ]
}
