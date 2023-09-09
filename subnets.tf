module "public_subnets" {
  source            = "./subnets"
  default_vpc_id    = var.default_vpc_id
  env               = var.env
  availability_zone = var.availability_zone

  for_each    = var.public_subnets
  cidr_block  = each.value.cidr_block
  name        = each.value.name
  internet_gw = lookup(each.value, "igw", false)
  nat_gw      = lookup(each.value, "ngw", false)

  vpc_id                    = aws_vpc.vpc.id
  vpc_peering_connection_id = aws_vpc_peering_connection.aws_vpc_connection.id
  tags                      = local.common_tags
  gateway_id                = aws_internet_gateway.igw.id
}

module "private_subnets" {
  source            = "./subnets"
  default_vpc_id    = var.default_vpc_id
  env               = var.env
  availability_zone = var.availability_zone

  for_each    = var.private_subnets
  cidr_block  = each.value.cidr_block
  name        = each.value.name
  internet_gw = lookup(each.value, "igw", false)
  nat_gw      = lookup(each.value, "ngw", false)

  vpc_id                    = aws_vpc.vpc.id
  vpc_peering_connection_id = aws_vpc_peering_connection.aws_vpc_connection.id
  tags                      = local.common_tags
  nat_gw_id                 = aws_nat_gateway.ngw.id
}