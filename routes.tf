# resource "aws_route_table" "private" {
#     vpc_id = aws_vpc.main.id

#     route = [
#         {
#             cidr_block                 = "0.0.0.0/0"
#             nat_gateway_id             = aws_nat_gateway.nat.id
#             carrier_gateway_id         = ""
#             destination_prefix_list_id = ""
#             egress_only_gateway_id     = ""
#             gateway_id                 = ""
#             instance_id                = ""
#             ipv6_cidr_block            = ""
#             local_gateway_id           = ""
#             network_interface_id       = ""
#             transit_gateway_id         = ""
#             vpc_endpoint_id            = ""
#             vpc_peering_connection_id  = ""
#         },
#     ]

#     tags = {
#         Name = "private-rt"
#     }

# }

resource "aws_route_table" "public" {
  vpc_id = var.my_network ? var.my_vpc : aws_vpc.main[0].id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = var.my_network ? var.my_gw : aws_internet_gateway.igw[0].id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "public-rt"
  }
}

# resource "aws_route_table_association" "private-a" {
#   subnet_id = aws_subnet.private-a.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private-b" {
#   subnet_id = aws_subnet.private-b.id
#   route_table_id = aws_route_table.private.id
# }

resource "aws_route_table_association" "public-a" {
  subnet_id      = var.my_network ? var.my_sub-a : aws_subnet.public-a[0].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = var.my_network ? var.my_sub-b : aws_subnet.public-b[0].id
  route_table_id = aws_route_table.public.id
}