#!/usr/bin/env bash

usage() {
  echo "Usage: ${0}"
  echo "Must supply the following environment variables to continue:"
  echo "  DB_HOST"
  echo "  DB_USERNAME"
  echo "  DB_PASSWORD"
  echo "  DB_DATABASE"
}

if [ "x${DB_HOST}" == "x" ]; then
	usage
	exit 255;
fi

if [ "x${DB_USERNAME}" == "x" ]; then
 	usage
 	exit 255
fi

if [ "x${DB_PASSWORD}" == "x" ]; then
	usage
	exit 255
fi

if [ "x${DB_DATABASE}" == "x" ]; then
	usage
	exit 255
fi

echo "Creating temporary directory..."
mkdir -p /tmp/db
cd /tmp/db

echo "Creating local database dump..."
mysqldump -u${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST} ${DB_DATABASE} | gzip > /tmp/db/db_snapshot.sql.gz
BACKUP_DATE=$(date +%Y%m%d%H%M%S)
echo "Pushing database snapshot to S3"
aws s3 cp /tmp/db/db_snapshot.sql.gz s3://${TARGET_S3_BUCKET}/db_snapshot-${BACKUP_DATE}.sql.gz
echo "Done."
