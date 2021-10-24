# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.main.id

  tags = { Name = "${var.stack_prefix}-igw" }
}
