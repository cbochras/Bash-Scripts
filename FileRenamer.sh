#!/bin/bash

echo "Enter the directory containing files to rename:"
read directory

echo "Enter the search string to find files to rename:"
read search_string

echo "Enter the replacement string for renaming files:"
read replacement_string

for file in "$directory"/*"$search_string"*; do
    new_file="${file//$search_string/$replacement_string}"
    mv "$file" "$new_file"
done

echo "Files have been successfully renamed."
