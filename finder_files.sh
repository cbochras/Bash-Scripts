#!/bin/bash

echo "Please enter the directory of the file"
read directory 

echo "Please enter the output directoryof the file"
read output_directory

echo "Please enter the name of the file"
read filename

find "$directory" -type f -executable -ls -print > "$output_directory/filename" 
