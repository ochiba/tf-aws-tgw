output "vpc" {
  value = data.aws_vpc.main
}

output "subnet_ids" {
  value = {
    public  = [for x in aws_subnet.public : x.id]
    private = [for x in aws_subnet.private : x.id]
    edge    = [for x in aws_subnet.edge : x.id]
  }
}

output "route_table_ids" {
  value = {
    public  = [aws_route_table.public.id]
    private = [for x in aws_route_table.private : x.id]
    edge    = [aws_route_table.edge.id]
  }
}