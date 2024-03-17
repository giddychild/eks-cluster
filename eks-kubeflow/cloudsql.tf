# Fetch most recent snapshot of the specified RDS instance if a snapshot ID exist
data "aws_db_snapshot" "latest" {
  count = data.external.rds_final_snapshot_exists.result["snapshot_id"] != null ? 1 : 0
  db_instance_identifier = "srcd-mlops-dev-postgressql-kfp"     #local.postgressql_instance_name
  most_recent            = true
}

# Execute external script and passes the RDS name argument to the script
data "external" "rds_final_snapshot_exists" {
  program = [
    "${path.module}/../check-rds-snapshots.sh",
    "srcd-mlops-dev-postgressql-kfp"   #local.postgressql_instance_name
  ]
}

resource "null_resource" "manage_final_snapshots" {
  triggers = {
    always_run = "${timestamp()}"
    db_instance_identifier = local.postgressql_instance_name
  }

  # Before destroying the instance, also consider deleting old final snapshots
  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/../delete-old-snapshots.sh ${self.triggers.db_instance_identifier}"
    environment = {
      DB_INSTANCE_IDENTIFIER = self.triggers.db_instance_identifier
    }
  }

  depends_on = [
    module.postgres-db
  ]
}

#Create/modify RDS database from snapshot
module "postgres-db" {
  source = "terraform-aws-modules/rds/aws"
  version = "6.3.0"
  identifier = local.postgressql_instance_name
  snapshot_identifier = data.external.rds_final_snapshot_exists.result["snapshot_id"]


  create_db_option_group    = false
  create_db_parameter_group = false

  engine                = "postgres"
  engine_version        = "14"
  family                = "postgres14"
  major_engine_version  = "14"
  instance_class        = "db.t3.small"
  allocated_storage     = 10
  backup_retention_period = 5

  tags = {
    Environment = "${var.environment}"
    Name        = local.postgressql_instance_name
  }

  db_name = "keycloak"
  username = "keycloak"
  manage_master_user_password = false
  password = local.keycloak_user_password
  port     = "5432"

  create_db_subnet_group = true
  subnet_ids = data.terraform_remote_state.infrastructure.outputs.private_subnet_ids

  skip_final_snapshot        = false
  final_snapshot_identifier_prefix = "final"

}
