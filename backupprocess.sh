#!/bin/bash

# Set variables for source and destination directories
source="/path/to/your/source/directory"
destination="/path/to/your/backup/directory"

# Create a timestamp for the backup file
timestamp=$(date +%Y%m%d_%H%M%S)

# Create the backup filename with timestamp
backup_file="backup_$timestamp.tar.gz"

# Create the destination directory if it doesn't exist
mkdir -p "$destination"

# Create the backup archive
tar -czvf "$destination/$backup_file" "$source"

# Optional: Remove backups older than a certain number of days
find "$destination" -type f -mtime +7 -delete

echo "Backup created: $destination/$backup_file"