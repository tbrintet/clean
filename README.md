# System Cleanup Script

This is a simple bash script that can be used to perform various cleaning tasks on a Debian-based Linux system. The script performs the following actions:

1. Updates the system package list and upgrades all installed packages.
2. Removes and purges any orphaned packages and cleans the package cache.
3. Clears the system journal logs.
4. Removes the wtmp and btmp files, which store login and logout history.
5. Removes all gzipped log files in the /var/log directory.
6. Removes various history and cache files in the /home directory.

The script must be run as root, and will prompt the user to run as root if not already running as root.

Please note that this script is intended for use on Debian-based systems and may not work properly on other Linux distributions.

## Usage

`sudo ./clean.sh [-d|--deep]`

The script takes one optional argument, `-d` or `--deep`, which when provided, causes the script to delete the Trash directory along with more cache files.

## Warning

Be cautious when running this script as it will delete all the logs and history files. Make sure to backup important files before running the script.

## Contributing

If you have any suggestions or improvements for this script, please feel free to open a pull request or an issue on the GitHub repository.

## License

This project is licensed under the GPL v3 License. See the [LICENSE](LICENSE) file for details
