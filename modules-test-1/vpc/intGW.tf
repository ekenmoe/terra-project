# Create Internet Gateway
resource "aws_internet_gateway" "Emile_igw" {
  vpc_id = aws_vpc.my_vpc.id
}