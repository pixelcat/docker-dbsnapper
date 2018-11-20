# DBSnapper

## Introduction

This image will connect to a supplied DB host, take a snapshot, 
and then copy the resulting snapshot to an S3 bucket.

This image is designed to be started when it's needed. It should
not be run long-term, as scheduling of a database snapshot is
beyond the scope of this application.

## Configuration

The following environment variables must be set:

* DB_HOST
* DB_USERNAME
* DB_PASSWORD
* DB_DATABASE
* TARGET_S3_BUCKET
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

## Running

docker run -e <DB_HOST={host} -e ...> -it pixelcat/dbsnapper:1.0

