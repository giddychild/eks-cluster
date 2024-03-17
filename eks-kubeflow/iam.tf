# ECR
data "aws_iam_policy_document" "ecr_kubeflow_mlops_eks_policy" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_kubeflow_mlops_eks_policy" {
  name        = "ecr_kubeflow_mlops_eks_policy"
  description = "Policy that allows access to ECR"
  policy      = data.aws_iam_policy_document.ecr_kubeflow_mlops_eks_policy.json
}

resource "aws_iam_role_policy_attachment" "ecr_kubeflow_mlops_eks_policy_attachment" {
  role       = module.eks.cluster_iam_role_name
  policy_arn = aws_iam_policy.ecr_kubeflow_mlops_eks_policy.arn
  depends_on = [module.eks, aws_iam_policy.ecr_kubeflow_mlops_eks_policy]
}