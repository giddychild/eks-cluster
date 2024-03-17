locals {
  region                    = "us-east-1"
  current_date = formatdate("YYMMDD", timestamp())
  eks_name                  = "${var.environment}-srcd-mlops-aws-${local.current_date}"
  eks_disk_size_gb          = 100
  eks_max_node_count        = 3
  keycloak_user_password    = var.KEYCLOAK_USER_PASSWORD
  KEYCLOAK_DB_SNAPSHOT = true
  postgressql_instance_name = "srcd-mlops-${var.environment}-postgressql-kfp"
}