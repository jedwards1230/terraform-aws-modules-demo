# Build VPC
# Creates a new Virtual Private Cloud (VPC) to provide a logically isolated section of the AWS cloud 
# where you can launch AWS resources in a defined virtual network.
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.env}-vpc"
  }
}

resource "aws_eip" "this" {
  tags = {
    "Name" = "${var.env}-eip"
  }
}

# Build Subnets
# Creates subnets within the VPC. Each subnet is a range of IP addresses in the VPC 
# where you can launch AWS resources, such as EC2 instances.
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.subnet_availability_zones[count.index]

  tags = merge(
    var.private_subnet_tags,
    {
      "Name" = "${var.env}-private-${count.index}"
    }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.subnet_availability_zones[count.index]

  tags = merge(
    var.public_subnet_tags,
    {
      "Name" = "${var.env}-public-${var.subnet_availability_zones[count.index]}"
    }
  )
}

# Build Internet Gateway
# Attaches an Internet Gateway to your VPC, enabling communication between resources in your VPC and the internet.
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.env}-igw"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    "Name" = "${var.env}-nat"
  }

  depends_on = [aws_internet_gateway.this]
}

# Build Route Table
# Creates a route table for your VPC. This route table contains a set of rules, called routes, 
# that determine where network traffic from your VPC is directed.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    "Name" = "${var.env}-rt-ngw"
  }
}

# Associate Subnet with Route Table
# Associates your subnets with the route table. This association ensures that the routing rules 
# in the route table apply to the network traffic from these subnets.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "${var.env}-rt-igw"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Prefix list
# A prefix list is a collection of CIDR blocks that are associated with a name.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list
data "aws_ec2_managed_prefix_list" "this" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

# Build Security Group
# Defines a security group for your VPC, which acts as a virtual firewall to control inbound and outbound traffic.
resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id

  # Allow inbound HTTP traffic from Cloudfront
  ingress {
    description     = "Allow inbound HTTP traffic from Cloudfront"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.this.id]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }


  # Default outbound rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
