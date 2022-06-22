
resource "aws_iam_role" "eksstart" {
  name = "eks-cluster-eksstart"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eksstart-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksstart.name
}

resource "aws_iam_role_policy_attachment" "eksstart-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eksstart.name
}

resource "aws_eks_cluster" "eksstart" {
  name     = "eksstarts"
  role_arn = aws_iam_role.eksstart.arn
  version  = 1.22

  vpc_config {
    subnet_ids = [
      var.my_network ? var.my_sub-a : aws_subnet.public-a[0].id,
      var.my_network ? var.my_sub-b : aws_subnet.public-b[0].id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eksstart-AmazonEKSClusterPolicy,
                aws_iam_role_policy_attachment.eksstart-AmazonEKSServicePolicy,]
}