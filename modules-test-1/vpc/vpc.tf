# Create VPC
resource "aws_vpc" "Emile_vpc" {
  cidr_block = "10.210.0.0/16"
}