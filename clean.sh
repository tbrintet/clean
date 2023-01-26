#!/bin/bash


deep=0

while [ $# -gt 0 ]
do
	case "$1" in
		-d|--deep)
			deep=1
			shift
			;;
		*)
			echo "Invalid argument: $1"
			exit 1
			;;
	esac
done


# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
	echo "Run as root"
	exit 1
fi

# Clear system journal logs
journalctl --flush --rotate
journalctl --vacuum-time=1s
journalctl --verify

# Clear login history by emptying the wtmp and btmp files
rm -vf /var/log/wtmp
rm -vf /var/log/btmp

# Remove gzipped log files in the /var/log directory
find /var/log -type f -name "*.gz" -delete -print


if [ $deep == 1 ]; then
	# Remove all cache files
	rm -rvf /home/*/.cache/*
	rm -rvf /root/.cache/*

	# Remove trash
	rm -rvf /home/*/.local/share/Trash/*
	rm -rvf /root/.local/share/Trash/*

else
	# Remove cache files that have not been used
	# in the past 60 days, for all users
	find /home/*/.cache/ -type f -atime +60 -delete -print
	find /root/.cache/ -type f -atime +60 -delete -print
fi

# Remove various history files in the /home directory
rm -vf /home/*/.bash_history
rm -vf /home/*/.lesshst
rm -vf /home/*/.python_history

# Update package list and upgrade all installed packages
apt update
apt full-upgrade -y

# Remove orphaned packages, clean package cache and
# remove old unused configuration files
apt autoremove --purge -y
apt clean
apt purge ~c -y

# Remove cache files
rm -rvf /var/cache/*
rm -rvf /var/tmp/*
