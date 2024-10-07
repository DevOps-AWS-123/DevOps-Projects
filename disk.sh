#!/bin/bash

# Set the disk usage threshold (in percentage)
THRESHOLD=80

# Use a distribution list to send alerts to multiple recipients
EMAIL="devops-team@example.com"

# Define the mail subject prefix
SUBJECT_PREFIX="Disk Space Alert"

# Get the hostname of the server
HOSTNAME=$(hostname)

# Define the log file to keep records of the alerts
LOGFILE="/var/log/disk_space_monitor.log"

# Check for the 'mail' command to ensure email notifications can be sent
if ! command -v mail &>/dev/null; then
  echo "mail command not found. Please install mailutils or sendmail to enable email alerts."
  exit 1
fi

# Loop through the output of the df command
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 " " $6 }' | while read output; do
  # Extract the usage percentage (without the % sign)
  usep=$(echo $output | awk '{ print $1 }' | sed 's/%//g')

  # Extract the partition name and mount point
  partition=$(echo $output | awk '{ print $2 }')
  mount_point=$(echo $output | awk '{ print $3 }')

  # If disk usage exceeds the threshold, send an email alert and log the event
  if [ $usep -ge $THRESHOLD ]; then
    SUBJECT="$SUBJECT_PREFIX on $HOSTNAME - $partition ($usep%)"
    MESSAGE="Warning: The partition \"$partition\" on $HOSTNAME is running out of space.\n\nDisk usage: $usep%\nMount point: $mount_point\n\nPlease take action to free up space."

    # Send an email alert to the distribution list
    echo -e "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"

    # Log the alert with timestamp
    echo "$(date): $MESSAGE" >>$LOGFILE
  fi
done

top # For a real-time view
# Or use:
ps aux --sort=-%mem | head -n 10 # Top memory consuming processes
ps aux --sort=-%cpu | head -n 10 # Top CPU consuming processes
