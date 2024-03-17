#!/bin/bash

db_id=$1
prefix="final-"

if [ -z "$db_id" ]; then
  echo "Usage: $0 <db_id>"
  exit 1
fi

# List and sort "final" snapshots, keeping the most recent one out of deletion
snapshots_to_delete=$(aws rds describe-db-snapshots --db-instance-identifier "$db_id" --query "reverse(sort_by(DBSnapshots[?starts_with(DBSnapshotIdentifier, \`${prefix}\`) == \`true\`],&SnapshotCreateTime))[1:].DBSnapshotIdentifier" --output text)

if [ "$snapshots_to_delete" == "None" ]; then
  echo "No old snapshots found to delete."
  exit 0
fi

# Loop through and delete old snapshots
for snapshot_id in $snapshots_to_delete; do
  echo "Deleting snapshot: $snapshot_id"
  aws rds delete-db-snapshot --db-snapshot-identifier "$snapshot_id"
done
