#Define External IP 
resource "aws_eip" "eip-nat" {
  vpc = true
}

resource "aws_nat_gateway" "demo-nat-gw" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = module.network.public_subnet_B_id
  depends_on    = [module.network.internet_gateway]
}

resource "aws_route_table" "rt-private" {
  vpc_id = module.network.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.network.nat_gateway_id
  }

  tags = {
    Name = "${var.PRIVATE_RT_NAME}"
  }
}

# route associations private
resource "aws_route_table_association" "private-B" {
  subnet_id      = module.network.private_subnet_id
  route_table_id = module.network.route_table_id
}
