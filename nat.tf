#Define External IP 
resource "aws_eip" "eip-nat" {
  vpc = true
}

resource "aws_nat_gateway" "demo-nat-gw" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.public-subnet-B.id
  depends_on    = [aws_internet_gateway.demo-gw]
}

resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo-nat-gw.id
  }

  tags = {
    Name = "${var.PRIVATE_RT_NAME}"
  }
}

# route associations private
resource "aws_route_table_association" "private-B" {
  subnet_id      = aws_subnet.private-subnet-B.id
  route_table_id = aws_route_table.rt-private.id
}
