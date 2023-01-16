#!/bin/bash


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

# Remove cache files in ~/.cache that have not been used in the past 60 days, for all users
find /home/*/.cache/ -type f -atime +60 -delete -print
find /root/.cache/ -type f -atime +60 -delete -print

# Remove various history files in the /home directory
rm -vf /home/*/.bash_history
rm -vf /home/*/.lesshst
rm -vf /home/*/.python_history

# Update package list and upgrade all installed packages
apt update
apt full-upgrade -y

# Remove orphaned packages, clean package cache and remove old unused configuration files
apt autoremove --purge -y
apt clean
apt purge ~c

# Remove cache files
rm -rvf /var/cache/*
