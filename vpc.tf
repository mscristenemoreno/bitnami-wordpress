module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "${local.tags.Name}-vpc"
  version = "3.11.0"

  cidr = var.network_address_space

  azs             = ["${var.aws_region}a"]
  private_subnets = ["20.0.1.0/24"]
  public_subnets  = ["20.0.10.0/24"]

  create_igw           = false
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = local.tags
}


