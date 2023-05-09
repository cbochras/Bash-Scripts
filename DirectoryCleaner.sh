#!/bin/bash

echo "Enter the directory to clean up:"
read directory

if [ ! -d "$directory" ]; then
  echo "Directory not found!"
  exit 1
fi

echo "Are you sure you want to delete all .bak files in $directory? (y/n)"
read confirm

if [ "$confirm" == "y" ]; then
  echo "Cleaning up $directory..."
  find "$directory" -type f -name "*.bak" -delete
  echo "Done!"
else
  echo "Cleanup canceled."
fi
