#!/bin/bash


# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "Run as root" 
   exit 1
fi

# Update package list and upgrade all installed packages
apt update
apt full-upgrade -y

# Remove orphaned packages, clean package cache and remove old unused configuration files
apt autoremove --purge -y
apt clean
apt purge ~c

# Remove cache files
rm -rvf /var/cache/*

# Clear system journal logs
journalctl --flush --rotate
journalctl --vacuum-time=1s
journalctl --verify

# Clear login history by emptying the wtmp and btmp files
rm -vf /var/log/wtmp
rm -vf /var/log/btmp

# Remove gzipped log files in the /var/log directory
find /var/log -type f -name "*.gz" -delete -print

# Remove bash history files in the /home directory
rm -vf /home/*/.bash_history
