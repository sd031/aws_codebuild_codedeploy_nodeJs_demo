#! /bin/bash
# DB_FILE_BACKUP_NAME="dbname.sql"
# S3_BUCKET_NAME="sample-bucket-sandip"

#mysqldump --add-drop-table -u admin -p`cat /etc/psa/.psa.shadow` dbname > $DB_FILE_BACKUP_NAME



if ! type aws >/dev/null 2>&1; then
echo "we don't have aws sli installed, so installing aws cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
else
echo "we aws cli installed, so continuing"
fi

aws s3 cp $DB_FILE_BACKUP_NAME "s3://${S3_BUCKET_NAME}"
