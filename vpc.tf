data "aws_availability_zone" "east1" {
  name = "sa-east-1a"
}

data "aws_availability_zone" "east2" {
  name = "sa-east-1b"
}

resource "aws_vpc" "primary_vpc" {
  cidr_block = "10.15.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.primary_vpc.id
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "ngt" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.external_subnet.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.external_subnet.id
}

resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngt.id
  }
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.route_table2.id
  subnet_id = aws_subnet.internal_subnet.id
}

resource "aws_subnet" "internal_subnet" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.vpc_private_subnet_cidr
  availability_zone = data.aws_availability_zone.east1.id
  map_public_ip_on_launch = false
}

resource "aws_subnet" "external_subnet" {
  vpc_id            = aws_vpc.primary_vpc.id
  cidr_block        = var.vpc_public_subnet_cidr
  availability_zone = data.aws_availability_zone.east1.id
}