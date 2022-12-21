variable "VPC_NAME" {}
variable "VPC_CIDR_BLOCK" {}
variable "GW_NAME" {}
variable "PUBLIC_RT_NAME" {}
variable "PRIVATE_RT_NAME" {}

variable "AVAILABILITY_ZONES" {
   type = list
}

variable "SUBNET_NAMES" {
   type = list
}
variable "SUBNET_IPS" {
   type = list
}