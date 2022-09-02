#!/bin/bash

#
# Runs 3 nmap on the target
#


while getopts ":t:" opt; 
do
    case "$opt" in

    t) target="$OPTARG"
    ;;
    
    esac
done

if [ -z "$target" ]; then
	echo "Usage :"
	echo "$0 -t 10.10.10.111"
	exit 1
fi

sudo nmap -sC -sV -oN nmap/initial.txt $target && \
sudo nmap -p- --min-rate 1000 -oN nmap/all-ports.txt $target && \
sudo nmap -sU -oN nmap/udp.txt $target
