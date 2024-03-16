### Associate Public Subnets with the public Route Table
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}

#### Associate private subnet with private route table

resource "aws_route_table_association" "nat_gateway" {
  subnet_id      = aws_subnet.nat_gateway.id
  route_table_id = aws_route_table.nat_gateway.id
}

##############################################################

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_subnet_associations" {
  count          = 3
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}


# Associate private subnets with the private route table
resource "aws_route_table_association" "private_subnet_associations" {
  count          = 3
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}