#!/bin/bash
# Requires the user account to be able to execute a sudo command without a password
# This is something to consider before undertaking

CHK_BAL="sudo btrfs balance status /mnt/volume"
CHK_SRB="sudo btrfs scrub status /mnt/volume"

SRB_RUN=""

IS_BAL_ALL=$($CHK_BAL)
IS_BAL_ARR=(${IS_BAL_ALL// / })
IS_BAL_CHK="${IS_BAL_ARR[4]}"
IS_BAL_ARR_SIZE=${#IS_BAL_ARR[@]}

IS_SRB_ALL=$($CHK_SRB)
IFS=","
IS_SRB_ARR=($IS_SRB_ALL)
IS_SRB_RUN=${IS_SRB_ARR[2]}
IS_SRB_TST=`sed '/running/q' <<<$IS_SRB_RUN | sed -e 's/^[ \t]*//'`

if [[ "$IS_BAL_CHK" == "running" ]] ; then
	RETURN="BTRFS Balancing ${IS_BAL_ARR[$IS_BAL_ARR_SIZE-2]}"
elif [[ "$IS_SRB_TST" == "running" ]] ; then
	echo SCRUBBING
else
	RETURN=""
fi

echo "${RETURN}"
#echo "\${#EF5A29}BALANCING ${IS_BAL_ARR[$IS_BAL_ARR_SIZE-2]}"
