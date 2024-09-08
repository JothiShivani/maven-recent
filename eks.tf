# IAM Role Policy Attachment for EKS Cluster
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  role       = "clusterrole_one"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  role       = "clusterrole_one"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# IAM Role Policy Attachment for Node Group
resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  role       = "new_noderule"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  role       = "new_noderule"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  role       = "new_noderule"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEBSCSIDriverPolicy" {
  role       = "new_noderule"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}



resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = "arn:aws:iam::605134465264:role/clusterrole_one"

  vpc_config {
    subnet_ids = ["subnet-09afdef515d2421b9", "subnet-03c8279e76a2e17ca"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
    
  # ]
}

# output "endpoint" {
#   value = aws_eks_cluster.example.endpoint
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.example.certificate_authority[0].data
# }

resource "aws_eks_node_group" "new-nodegroup" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "node-group-name"
  node_role_arn   = "arn:aws:iam::605134465264:role/new_noderule"
  subnet_ids      = ["subnet-09afdef515d2421b9", "subnet-03c8279e76a2e17ca"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  #   aws_iam_role_policy_attachment.example-AmazonEBSCSIDriverPolicy,
  # ]

}