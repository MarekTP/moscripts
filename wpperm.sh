#! /bin/bash

function showhelp () {
	echo "
	Usage:
	wpperm -h -d [path]
	-h --help       show this text
	-d --dir  path to wordpress root"
}

function chmodwp () {
	# echo ${d}
	cd ${d}
	ls -lG
	chown www-data:www-data  -R * # Let Apache be owner
	find . -type d -exec chmod 0777 {} \;  # Change directory permissions rwxr-xr-x
	find . -type f -exec chmod 0666 {} \;  # Change file permissions rw-rw-rw-
	ls -lG
}

#check if run as root or wheel (sudo)
if [ "$(id -u)" != "0" ]; then
	echo "Script must run under root privileges or in sudo" 1>&2 
	exit 1
fi

#parse cmd parameters
if [ $# -eq 0 ]; then
	>&2 echo "Missing arguments"
	showhelp
	exit 1
else
	while true option
	do
		case $1 in
			-h|--help)
				showhelp
				exit 0
				;;
			-d|--dir)
				d=$2
				chmodwp d
				exit 0
				;;
    		esac
		shift 2
	done
fi


