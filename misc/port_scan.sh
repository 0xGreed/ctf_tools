#!/bin/bash

#
# Given an IP, it scans all the ports of the machine
# required : bash ; nc
#

while getopts ":i:" opt; 
do
    case "$opt" in

    i) target="$OPTARG"
    ;;
    
    esac
done

if [ -z "$target" ]; then
	echo "Usage :"
	echo "$0 -i 127.0.0.1"
	exit 1
fi

for i in $(seq 1 10000)};
do
	timeout 0.5 nc -zv $target $i > /dev/null && echo "[+] $i : OPEN"
done
