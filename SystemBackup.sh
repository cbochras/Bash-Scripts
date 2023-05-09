#!/bin/bash

# Prompt user for backup or restore mode
echo "Choose mode: backup or restore?"
read mode

# Backup mode
if [ "$mode" == "backup" ]; then
    echo "Enter the directory to backup:"
    read directory

    echo "Enter the backup destination directory:"
    read backup_dir

    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
    backup_file="$backup_dir/backup_$timestamp.tar.gz"
    tar -czvf "$backup_file" "$directory"

    echo "Backup complete. Backup file saved to $backup_file."

elif [ "$mode" == "restore" ]; then
    echo "Enter the backup file to restore:"
    read backup_file

    echo "Enter the restore destination directory:"
    read restore_dir

    tar -xzvf "$backup_file" -C "$restore_dir"

    echo "Restore complete. Files restored to $restore_dir."
    
else
    echo "Invalid mode. Please choose backup or restore."
fi
