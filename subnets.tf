# resource "aws_subnet" "private-a" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "192.168.0.0/24"
#     availability_zone = "ap-northeast-2a"

#     tags = {
#         "Name"                            = "private-a"
#         "kubernetes.io/fole/internal-elb" = "1"
#         "kubernetes.io/cluster/eksstart"  = "owned"
#     }
# }

# resource "aws_subnet" "private-b" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "192.168.1.0/24"
#     availability_zone = "ap-northeast-2b"

#     tags = {
#         "Name"                            = "private-b"
#         "kubernetes.io/fole/internal-elb" = "1"
#         "kubernetes.io/cluster/eksstart"  = "owned"
#     }
# }

resource "aws_subnet" "public-a" {
    count             =  var.my_network ? 0 : 1
    vpc_id            =  var.my_network ? var.my_vpc : aws_vpc.main[0].id
    cidr_block        = "192.168.2.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true

    tags = {
        "Name"                            = "public-a"
        "kubernetes.io/fole/elb"          = "1"
        "kubernetes.io/cluster/eksstart"  = "owned"
    }
}

resource "aws_subnet" "public-b" {
    count             = var.my_network ? 0 : 1
    vpc_id            = var.my_network ? var.my_vpc : aws_vpc.main[0].id
    cidr_block        = "192.168.3.0/24"
    availability_zone = "ap-northeast-2b"
    map_public_ip_on_launch = true

    tags = {
        "Name"                            = "public-b"
        "kubernetes.io/fole/elb"          = "1"
        "kubernetes.io/cluster/eksstart"  = "owned"
    }
}