#!/bin/bash

echo "Enter the source directory to backup:"
read source_dir

echo "Enter the destination directory to store backups:"
read dest_dir

backup_file="$dest_dir/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

echo "Creating backup at $backup_file..."
tar czf "$backup_file" "$source_dir"
echo "Backup completed successfully!"
