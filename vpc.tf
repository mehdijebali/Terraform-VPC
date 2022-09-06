#Create AWS VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "demo-vpc"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "public-subnet-A" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public-subnet-A"
  }
}

resource "aws_subnet" "public-subnet-B" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public-subnet-B"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "private-subnet-A" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "private-subnet-A"
  }
}

resource "aws_subnet" "private-subnet-B" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "private-subnet-B"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-gw"
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
    Name = "demo-rt"
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