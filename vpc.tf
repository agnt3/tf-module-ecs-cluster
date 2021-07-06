data "aws_availability_zone" "private_subnet" {
  name = var.vpc_private_subnet_az
}

data "aws_availability_zone" "public_subnet" {
  name = var.vpc_public_subnet_az
}

resource "aws_vpc" "cluster_vpc" {
  cidr_block = var.vpc_cidr
}

# Public subnet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.cluster_vpc.id
}

resource "aws_eip" "public_subnet_elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "ngt" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.public_subnet_elastic_ip.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = var.vpc_public_subnet_cidr
  availability_zone = data.aws_availability_zone.public_subnet.id
}

# Private subnet
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.cluster_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngt.id
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.cluster_vpc.id
  cidr_block        = var.vpc_private_subnet_cidr
  availability_zone = data.aws_availability_zone.private_subnet.id
  map_public_ip_on_launch = false
}