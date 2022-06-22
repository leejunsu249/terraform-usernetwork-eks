resource "aws_internet_gateway" "igw" {
    count = var.my_network ? 0 : 1
    vpc_id = var.my_network ? var.my_vpc : aws_vpc.main[0].id

    tags = {
        Name = "eks-tf-igw"
    }
}