#!/bin/bash

echo "Enter the directory to check:"
read directory
echo "Enter the file size limit in bytes:"
read limit

for file in $(find "$directory" -type f); do
    size=$(stat --printf="%s" "$file")
    if [[ $size -gt $limit ]]; then
        echo "File '$file' exceeds the size limit of $limit bytes"
    fi
done
