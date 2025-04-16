# 1. Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {

  tags = {
    Name = "java-app-nat-eip"
  }
}

# 2. NAT Gateway in Public Subnet 1
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "java-app-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# 3. Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "java-app-private-rt"
  }
}

# 4. Route: Private Subnets go through NAT
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# 5. Associate Private Subnet 1 with Private Route Table
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

# 6. Associate Private Subnet 2 with Private Route Table
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}
