# resource "aws_eip" "nat" {
#     vpc = true

#     tags = {
#         Name = "Nat"
#     }
# }

# resource "aws_nat_gateway" "nat" {
#     allocation_id = aws_eip.nat.id
#     subnet_id     = aws_subnet.public-a.id

#     tags = {
#         Name = "nat"
#     }

#     depends_on = [aws_internet_gateway.igw]
# }