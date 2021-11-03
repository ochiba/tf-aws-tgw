variable "stack_prefix" {}
variable "region" {}
variable "system_cidrs" {}
variable "vpc" {}
variable "subnet_public" {
  default = []
}
variable "subnet_private" {
  default = []
}
variable "subnet_edge" {
  default = []
}
variable "is_hub" {
  default = false
}
variable "tgw_id" {}
variable "tgw_ram_name" {}
variable "tgw_route_table_ids" {}