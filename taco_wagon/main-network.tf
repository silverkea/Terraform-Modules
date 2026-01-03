# VPC Resources

data "aws_availability_zones" "available" {
  state = "available"
}

# NETWORKING - Commented out manual resources, now using VPC module below #
# resource "aws_vpc" "main" {
#   cidr_block           = var.vpc_address_range
#   enable_dns_hostnames = true
#
#   tags = {
#     Name = "${var.prefix}-vpc"
#   }
#
# }
#
# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id
#
# }
#
# resource "aws_subnet" "public_subnets" {
#   count = length(var.vpc_public_subnet_ranges)
#
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.vpc_public_subnet_ranges[count.index]
#   availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
#   map_public_ip_on_launch = true
#
#   tags = {
#     Name = "${var.prefix}-public-subnet-${count.index + 1}"
#   }
# }
#
# # ROUTING #
# resource "aws_route_table" "default" {
#   vpc_id = aws_vpc.main.id
#
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }
# }
#
# resource "aws_route_table_association" "public_subnets" {
#   count          = length(var.vpc_public_subnet_ranges)
#   subnet_id      = aws_subnet.public_subnets[count.index].id
#   route_table_id = aws_route_table.default.id
# }

# VPC Module - replaces manual resources above
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  # Basic VPC configuration
  name = "${var.prefix}-vpc"
  cidr = var.vpc_address_range

  # Dynamically get AZs based on the number of public subnets needed
  azs = slice(data.aws_availability_zones.available.names, 0, length(var.vpc_public_subnet_ranges))

  # Public subnets only (no private subnets for this simple setup)
  public_subnets = var.vpc_public_subnet_ranges

  # Map public IPs on launch (equivalent to map_public_ip_on_launch = true)
  map_public_ip_on_launch = true

  # Internet Gateway (automatically created for public subnets)
  create_igw = true

  # No NAT Gateway needed for public-only subnets
  enable_nat_gateway = false
  enable_vpn_gateway = false

  # DNS settings
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tags
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}