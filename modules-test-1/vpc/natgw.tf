
# Create NAT Gateway for each Public Subnet
resource "aws_nat_gateway" "nat_gateways" {
  count         = 3
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  depends_on = [aws_internet_gateway.my_igw]
}

