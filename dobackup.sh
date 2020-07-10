#!/bin/sh
echo "creating archive"
cd /data
tar zcf /tmp/$BACKUP_NAME.zip .
echo "uploading archive to S3"
aws s3 cp /tmp/*.zip $S3_BUCKET_URL
echo "removing local archive"
rm /tmp/*.
echo "done"

echo "Checking for logged in users..."
players=$(rcon-cli list | head -1 | cut -d' ' -f3)
[ $players == '0' ] && rcon-cli stop
