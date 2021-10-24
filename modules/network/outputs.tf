output "vpc" {
  value = data.aws_vpc.main
}

output "subnet_public" {
  value = aws_subnet.public
}
output "subnet_private" {
  value = aws_subnet.private
}
output "subnet_edge" {
  value = aws_subnet.edge
}
