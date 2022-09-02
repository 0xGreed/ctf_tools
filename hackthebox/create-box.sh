#!/bin/bash

#
# Creates a basic directory structure
#

usage()
{
	echo "Parameters needed :"
	echo "-n <BOX_NAME>"
	echo "-o <linux,windows,android>"
	echo "-d <easy,medium,hard>"
	echo "-i <BOX_IP>"
	echo ""
	echo "Example :"
	echo "./create-box -n bashed -o linux -d easy -i 10.10.10.100"
	exit 1
}

checkOS()
{
	os=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	valid_os=("linux" "windows" "android")

	if [[ ! "${valid_os[*]}" =~ "$os" ]]; then
	    echo "Valid OS :"
	    echo "<linux,windows,android>"
	    exit 2
	fi
}

checkDifficulty()
{
	difficulty=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	valid_difficulty=("easy" "medium" "hard" "insane")

	if [[ ! "${valid_difficulty[*]}" =~ "$difficulty" ]]; then
	    echo "Valid difficulties :"
	    echo "<easy,medium,hard,insane>"
	    exit 3
	fi
}

#-----------------------------

while getopts ":n:o:d:i:" opt; do
	case "$opt" in

    n) name="$OPTARG"
    ;;

    o) os="$OPTARG"
    ;;

    d) difficulty="$OPTARG"
    ;;

    i) ip="$OPTARG"
    ;;

	esac
done

if [ -z "$name" ] || [ -z "$os" ] || [ -z "$difficulty" ] || [ -z "$ip" ]; then
    usage
fi

checkOS "$os"
os=$(echo ${os^})

checkDifficulty "$difficulty"
difficulty=$(echo ${difficulty^})

new_folder="./$name"
readme_file="$new_folder/README.md"

/usr/bin/mkdir "$new_folder"
/usr/bin/mkdir "$new_folder/www"
/usr/bin/mkdir "$new_folder/nmap"
/usr/bin/cp ./README-template.md "$readme_file"

now=$(date '+%d-%m-%Y')
name=$(echo ${name^})
/usr/bin/sed -i "s/<NAME>/$name/g" "$readme_file"
/usr/bin/sed -i "s/<OS>/$os/g" "$readme_file"
/usr/bin/sed -i "s/<DIFFICULTY>/$difficulty/g" "$readme_file"
/usr/bin/sed -i "s/<IP>/$ip/g" "$readme_file"
/usr/bin/sed -i "s/<DATE>/$now/g" "$readme_file"
