resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet" {

  depends_on = [aws_vpc.vpc]

  for_each = var.subnet_az_cidr

  cidr_block              = each.value
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.key
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.gateway_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "subnet_association" {
  for_each       = aws_subnet.subnet
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = var.internet_ipv4
  gateway_id             = aws_internet_gateway.gateway.id
  depends_on             = [aws_route_table.route_table]
}