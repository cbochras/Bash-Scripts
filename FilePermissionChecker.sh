#!/bin/bash

echo "Enter the directory to check permissions:"
read directory

files=$(find "$directory" -type f)

# Check the permissions of each file and print a warning message if permissions are insecure
for file in $files
do
  perms=$(stat -c "%a" "$file")
  if [[ "$perms" =~ [0-2][0-2][0-2] ]]; then
    echo "Warning: $file has insecure permissions ($perms)"
  fi
done
