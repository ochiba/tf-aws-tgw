output "vpc" {
  value = module.hub_network.vpc
}
output "subnet_ids" {
  value = module.hub_network.subnet_ids
}
output "route_table_ids" {
  value = module.hub_network.route_table_ids
}
