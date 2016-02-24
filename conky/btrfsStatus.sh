#!/bin/bash
BTR_DIR="/mnt/volume"
CHK_BAL="sudo btrfs balance status $BTR_DIR"
CHK_SRB="sudo btrfs scrub status $BTR_DIR"
CHK_USED="btrfs fi df $BTR_DIR"

IS_BAL_ALL=$($CHK_BAL)
IS_BAL_ARR=(${IS_BAL_ALL// / })
IS_BAL_CHK="${IS_BAL_ARR[4]}"

IS_SRB_ALL=$($CHK_SRB)
IS_SRB_RUN=`grep -oP '(?<=\d\d:\d\d:\d\d,) not running' <<<$IS_SRB_ALL`

if [[ "$IS_BAL_CHK" == "running" ]] ; then
	BAL_ARR_SIZE=${#IS_BAL_ARR[@]}
	RETURN="BTRFS Balancing ${IS_BAL_ARR[$BAL_ARR_SIZE-2]}"
elif [[ "$IS_SRB_RUN" != "running" ]] ; then
	echo SCRUBBING
	BTR_USED=$($CHK_USED)
	BTR_USED_ARR=($BTR_USED)
	BTR_USED_AMT=${BTR_USED_ARR[3]}
	BTR_USED_VAL=`sed 's/used=//;s/TiB$/*1024*1024*1024*1024/g;s/GiB$/*1024*1024*1024/g;s/MiB$/*1024*1024/g;s/KiB$/*1024/g' <<<$BTR_USED_AMT | bc -l`
	BTR_SRB_VAL=`grep -oP '(?<=total bytes scrubbed: )[0-9.TGMKiB]+(?= with)' <<<$IS_SRB_ALL | sed 's/TiB$/*1024*1024*1024*1024/g;s/GiB$/*1024*1024*1024/g;s/MiB$/*1024*1024/g;s/KiB$/*1024/g' | bc -l`
	BTR_PCT=100.0*$BTR_SRB_VAL/$BTR_USED_VAL
	BTR_PCT_RTN=`bc -l <<< $BTR_PCT | awk '{printf("%d\n",$1 + 0.5)}'`
	RETURN="BTRFS Scrubbing $BTR_PCT_RTN"
else
	RETURN=""
fi

echo "${RETURN}"
