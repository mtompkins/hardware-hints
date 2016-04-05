#!/bin/bash

test -n "$DEVS" || DEVS=$(grep '\<btrfs\>' /proc/mounts | awk '{ print $1 }' | sort -u)
for BTR_DIR in $DEVS
do

	#BTR_DIR="/mnt/volume"
	CHK_SRB="btrfs scrub status $BTR_DIR"

	IS_SRB_ALL=$($CHK_SRB)
	IS_SRB_RUN=`grep -o 'not running\|finished\|aborted' <<<$IS_SRB_ALL`

	if [ "$IS_SRB_RUN" == "not running" -o "$IS_SRB_RUN" == "finished" -o "$IS_SRB_RUN" == "aborted" ] ; then

		CAP_HOSTNAME=`echo $HOSTNAME | tr [a-z] [A-Z]`
		EMAIL_SUBJECT_PREFIX="$CAP_HOSTNAME BTRFS - "
		TMP_EMAIL_TEXT="/tmp/email_text.txt"

		rm -f $TMP_EMAIL_TEXT

		starttime="$(date "+%Y-%m-%d %H:%M:%S")"

		# timestamp the job
		logger "BTRFS scrub job started on $BTR_DIR" 
		echo "BTRFS scrub job of $BTR_DIR started on `date`" > $TMP_EMAIL_TEXT
		echo "--------------------------------------------------------------------------------" >> $TMP_EMAIL_TEXT

		ionice -c 3 nice -5 btrfs scrub start -Bd $BTR_DIR

		journalctl -q -k --since "$starttime" | grep BTRFS >> $TMP_EMAIL_TEXT

		echo "--------------------------------------------------------------------------------" >> $TMP_EMAIL_TEXT
		echo "BTRFS scrub job of $BTR_DIR finished on `date`" >> $TMP_EMAIL_TEXT
		logger "BTRFS scrub job finished on $BTR_DIR"

		mail -s "$(echo -e "$EMAIL_SUBJECT_PREFIX Scrub Job Completed\nContent-Type: text/html")" root < $TMP_EMAIL_TEXT 
		
		rm -f $TMP_EMAIL_TEXT

	else
		logger "Active BTRFS scrub detected on $BTR_DIR. Not starting a new instance."
	fi

done

exit 0;
