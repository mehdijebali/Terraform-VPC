#Create AWS VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block       = var.VPC_CIDR_BLOCK
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.VPC_NAME}"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "public-subnet-A" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.SUBNET_IPS[0]
  map_public_ip_on_launch = "true"
  availability_zone       = var.AVAILABILITY_ZONES[0]

  tags = {
    Name = "${var.SUBNET_NAMES[0]}"
  }
}

resource "aws_subnet" "public-subnet-B" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.SUBNET_IPS[1]
  map_public_ip_on_launch = "true"
  availability_zone       = var.AVAILABILITY_ZONES[1]

  tags = {
    Name = "${var.SUBNET_NAMES[1]}"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "private-subnet-A" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.SUBNET_IPS[2]
  map_public_ip_on_launch = "false"
  availability_zone       = var.AVAILABILITY_ZONES[0]

  tags = {
    Name = "${var.SUBNET_NAMES[2]}"
  }
}

resource "aws_subnet" "private-subnet-B" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = var.SUBNET_IPS[3]
  map_public_ip_on_launch = "false"
  availability_zone       = var.AVAILABILITY_ZONES[1]

  tags = {
    Name = "${var.SUBNET_NAMES[3]}"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "${var.GW_NAME}"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "${var.PUBLIC_RT_NAME}"
  }
}

resource "aws_route_table_association" "public-A" {
  subnet_id      = aws_subnet.public-subnet-A.id
  route_table_id = aws_route_table.demo-rt.id
}

resource "aws_route_table_association" "public-B" {
  subnet_id      = aws_subnet.public-subnet-B.id
  route_table_id = aws_route_table.demo-rt.id
}

#Module Outputs
output "vpc_id" {
  value = aws_vpc.demo-vpc.id
} 

output "internet_gateway" {
  value = aws_internet_gateway.demo-gw
} 

output "public_subnet_A_id" {
  value = aws_subnet.public-subnet-A.id
} 

output "private_subnet_id" {
  value = aws_subnet.private-subnet-B.id
} 

output "public_subnet_B_id" {
  value = aws_subnet.public-subnet-B.id
} 