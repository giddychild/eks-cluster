terraform {
  backend "s3" {
    bucket = "seyi-eks-project"
    key    = "eks/eks-cluster/state"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = { 
    bucket = "seyi-eks-project"
    key    = "eks/eks-infrastructure/state"
    region = "us-east-1"
  }
}