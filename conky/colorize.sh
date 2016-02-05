#!/bin/bash

MIN=$1
MAX=$2
TEMPERATURE=$3

if [ "$TEMPERATURE" -lt "$MIN" ] ; then
	GRADIENT=0
elif [ "$TEMPERATURE" -gt "$MAX" ] ; then
	GRADIENT=100
else
	GRADIENT=$(bc<<<"scale=2;($TEMPERATURE - $MIN)*100/($MAX - $MIN)")
fi

if [ $(printf "%.0f" "$GRADIENT") -le 50 ] ; then
	GREEN=255
else
	let GREEN=$(bc<<<"256-(($GRADIENT-50)*512)/100")
fi

if [ $(printf "%.0f" "$GRADIENT") -ge 50 ] ; then
	RED=255
else
	let RED=$(bc<<<"($GRADIENT*512)/100")
fi

HEX=$(printf "%02x\n" $RED)$(printf "%02x\n" $GREEN)00
echo "\${#${HEX}}$TEMPERATURE"

