resource "aws_eip" "nat_eip" {
  count = length(var.private_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "my-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "my_natgw" {
  count         = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)

  tags = {
    Name = "my-nat-gw-${count.index + 1}"
  }
}