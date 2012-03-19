#!/bin/bash
log="/tmp/$id.log"

echo "++ START BACKUP '$id' $(date)" > $log
echo "" >> $log
echo "host: $(hostname -f)" >> $log
echo "" >> $log

while read line
do
echo "+ backup '$line' $(date)" >> $log
rsync -a --stats --delete --password-file=/etc/rsync.secret "$line" backup@nas1::backup/rtr2/$id/ >> $log
echo "" >> $log
echo "- end backup '$line' $(date)" >> $log
echo "" >> $log
done < "selections.txt"

echo "-- END BACKUP '$id' $(date)" >> $log

SUBJECT="BACKUP '$id' of '$(hostname -f)'"
TO="obrien.timothy@bse.vic.edu.au"
/usr/bin/mail -s "$SUBJECT" "$TO" -a "From: Backup <helpdesk@bse.vic.edu.au>" < $log


