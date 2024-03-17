# eks-cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 19.21.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ecr_kubeflow_mlops_eks_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.ecr_kubeflow_mlops_eks_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.ecr_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.ecr_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_iam_policy_document.ecr_kubeflow_mlops_eks_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_KEYCLOAK_USER_PASSWORD"></a> [KEYCLOAK\_USER\_PASSWORD](#input\_KEYCLOAK\_USER\_PASSWORD) | Keycloak password passed in from Bitbucket Secured Variable | `string` | n/a | yes |
| <a name="input_WG_PRIVATE_KEY"></a> [WG\_PRIVATE\_KEY](#input\_WG\_PRIVATE\_KEY) | Wireguard Private Key passed in from Bitbucket Secured Variable | `string` | n/a | yes |
| <a name="input_WG_PUBLIC_KEY"></a> [WG\_PUBLIC\_KEY](#input\_WG\_PUBLIC\_KEY) | Wireguard Public Key passed in from Bitbucket Secured Variable | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Denotes the environment you want to deploy to (either dev or prod) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
