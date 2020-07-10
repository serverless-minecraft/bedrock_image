#!/bin/bash

echo "registering Route53 for ${baseTaskName}.${domainName}"
set -x
export zoneID=$(aws route53 list-hosted-zones-by-name --dns-name $domainName --query "HostedZones[?Name==\`$domainName.\`].Id" --output text | cut -d'/' -f3)
export ipaddr=$(curl ipinfo.io/ip)
cat /route53_upsert_template.json | sed s/NAME/"${baseTaskName}.${domainName}."/ | sed s/IPADDR/$ipaddr/ > /route53_upsert.json
aws route53 change-resource-record-sets --hosted-zone-id ${zoneID} --change-batch file:///route53_upsert.json
set +x

cd /data && wget -qO- "$WORLD" | tar xvf -

echo "creating crontab"
echo -e "$CRON_SCHEDULE /dobackup.sh\n" > /etc/crontabs/root
echo "starting crond"
crond -b

exec /opt/bedrock-entry.sh
