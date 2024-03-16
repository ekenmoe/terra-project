
# Create 3 Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = 3
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Create 3 Private Subnets
resource "aws_subnet" "private_subnets" {
  count      = 3
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.${count.index + 10}.0/24"

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}