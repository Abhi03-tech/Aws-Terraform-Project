data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  map_public_ip_on_launch = false
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-private-subnet-${count.index + 1}"
  }
}