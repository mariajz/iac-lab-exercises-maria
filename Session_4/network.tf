data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet("192.168.1.0/25", 3, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.prefix}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet("192.168.1.0/25", 3, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.prefix}-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "secure" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet("192.168.1.0/25", 3, count.index + 4)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.prefix}-secure-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-internet-gateway", var.prefix)
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = format("%s-eip-nat", var.prefix)
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = format("%s-nat-gateway", var.prefix)
  }
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = format("%s-public-route-table", var.prefix)
  }
}

# Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = format("%s-private-route-table", var.prefix)
  }
}


# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# import {
#   to = aws_subnet.extra_subnet
#   id = "subnet-035a7283f66a96d0d"
# }

# resource "aws_subnet" "extra_subnet" {
#   vpc_id            = "vpc-0f49db40e4d36489c"
#   cidr_block        = "192.168.1.96/28"
#   availability_zone = "ap-southeast-2a"
#   tags = {
#     Name = "maria-iac-lab-public-subnet-3"
#   }
# }

# resource "aws_subnet" "public_subnet_3" {
#   vpc_id            = "vpc-0f49db40e4d36489c"
#   cidr_block        = "192.168.1.96/28"
#   availability_zone = "ap-southeast-2a"
#   tags = {
#     Name = "maria-iac-lab-public-subnet-3"
#   }
# }

# moved {
#   from = aws_subnet.extra_subnet
#   to   = aws_subnet.public_subnet_3
# }
