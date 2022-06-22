resource "aws_vpc" "main" {
    count      =  var.my_network ? 0 : 1
    cidr_block = "192.168.0.0/16"

    tags = {
        Name = "eks-tf-vpc"
    }
}