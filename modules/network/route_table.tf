# Public subnet
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtbl-public"
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
resource "aws_route_table" "private_a" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtbl-private_a"
    Tier = "Private"
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtbl-private_c"
    Tier = "Private"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = (count.index % 2 == 0) ? aws_route_table.private_a.id : aws_route_table.private_c.id

  depends_on = [
    aws_subnet.private,
    aws_route_table.private_a,
    aws_route_table.private_c
  ]
}

# Edge subnet
resource "aws_route_table" "edge" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Name = "${var.stack_prefix}-rtbl-edge"
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
