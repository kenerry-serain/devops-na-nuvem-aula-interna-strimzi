resource "aws_eks_cluster" "this" {
  name                      = var.eks_cluster.name
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = var.eks_cluster.enabled_cluster_log_types

  access_config {
    authentication_mode                         = var.eks_cluster.access_config_authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.eks_cluster.access_config_bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    subnet_ids = aws_subnet.privates[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_AmazonEKSClusterPolicy,
  ]
}
