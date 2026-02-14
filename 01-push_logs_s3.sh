#!/bin/bash

# Variables
LOG_DIR="/var/log/myapp"
BACKUP_DIR="/tmp/log_backups"
BUCKET_NAME="my-app-logs-backup"
DATE=$(date +%F-%H%M)
ARCHIVE_NAME="logs-$DATE.tar.gz"

# 1. Create a temporary staging area
mkdir -p $BACKUP_DIR

# 2. Compress the logs (Tarball)
tar -czf $BACKUP_DIR/$ARCHIVE_NAME $LOG_DIR/*.log

# 3. Push to S3
aws s3 cp $BACKUP_DIR/$ARCHIVE_NAME s3://$BUCKET_NAME/

# 4. Cleanup local temp files
rm -f $BACKUP_DIR/$ARCHIVE_NAME

# 5. (Optional) Cleanup original logs older than 7 days
find $LOG_DIR -name "*.log" -mtime +7 -delete