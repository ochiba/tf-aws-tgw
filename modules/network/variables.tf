variable "stack_prefix" {}
variable "region" {}
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
