data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "main"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.available.names
  public_subnets = [
    cidrsubnet("192.168.1.0/25", 3, 0),
    cidrsubnet("192.168.1.0/25", 3, 1),
  ]
  private_subnets = [
    cidrsubnet("192.168.1.0/25", 3, 2),
    cidrsubnet("192.168.1.0/25", 3, 3),
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "${var.prefix}-vpc"
  }
}
