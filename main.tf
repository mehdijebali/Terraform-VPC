provider "aws" {
  region     = var.AWS_REGION
}

module "network" {
    source      = "./modules/network"

    VPC_NAME = var.VPC_NAME
    VPC_CIDR_BLOCK  = var.VPC_CIDR_BLOCK
    GW_NAME = var.GW_NAME
    PUBLIC_RT_NAME = var.PUBLIC_RT_NAME
    AVAILABILITY_ZONES = var.AVAILABILITY_ZONES
    SUBNET_NAMES = var.SUBNET_NAMES
    SUBNET_IPS = var.SUBNET_IPS
}