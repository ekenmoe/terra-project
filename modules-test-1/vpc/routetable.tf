### Create a public Route Table
resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_route_table_1"
  }
}

resource "aws_route_table" "public_route_table_2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_route_table_2"
  }
}

resource "aws_route_table" "public_route_table_3" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_route_table_3"
  }
}

##### create private route

resource "aws_route_table" "private_route_table_1" {

  vpc_id = aws_vpc.my_vpc.id
  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
  tags = {
    Name = "private_route_table_1"
  }
}

resource "aws_route_table" "private_route_table_2" {

  vpc_id = aws_vpc.my_vpc.id
  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }
  tags = {
    Name = "private_route_table_1"
  }
}

resource "aws_route_table" "private_route_table_3" {

  vpc_id = aws_vpc.my_vpc.id
  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_3.id
  }
  tags = {
    Name = "private_route_table_1"
  }
}