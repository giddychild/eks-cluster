#!/bin/bash

db_id=$1
prefix="final"

if [ -z "${db_id}" ]; then
  echo "Usage: $0 <db_id>"
  exit 1
fi

# Fetch the most recent snapshot matching the prefix
snapshot_id=$(aws rds describe-db-snapshots --db-instance-identifier "$db_id" --query "DBSnapshots[?starts_with(DBSnapshotIdentifier, \`${prefix}\`)].DBSnapshotIdentifier | sort(@) | [-1]" --output text 2> /dev/null)
aws_result=$?

if [ ${aws_result} -eq 0 ] && [ ! -z "${snapshot_id}" ] && [ "${snapshot_id}" != "None" ]; then
  jq -n --arg id "$snapshot_id" '{"snapshot_id": $id}'
else
  jq -n '{"snapshot_id": null}'
fi
