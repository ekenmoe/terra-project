
# Create Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eips" {
  count = 3
}
