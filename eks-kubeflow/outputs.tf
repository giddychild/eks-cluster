output "eks_oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

