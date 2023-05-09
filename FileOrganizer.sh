#!/bin/bash

echo "Enter the directory to organize:"
read directory

mkdir -p "$directory/images"
mkdir -p "$directory/documents"
mkdir -p "$directory/music"
mkdir -p "$directory/videos"
mkdir -p "$directory/others"

for file in "$directory"/*
do
    if [[ -f "$file" ]]
    then
        # Get file extension
        extension="${file##*.}"

        case "$extension" in
            jpg|jpeg|png|gif)
                mv "$file" "$directory/images/"
                ;;
            pdf|doc|docx|txt)
                mv "$file" "$directory/documents/"
                ;;
            mp3|wav|ogg)
                mv "$file" "$directory/music/"
                ;;
            mp4|mov|avi|wmv)
                mv "$file" "$directory/videos/"
                ;;
            *)
                mv "$file" "$directory/others/"
                ;;
        esac
    fi
done

echo "Organizing files in $directory completed!"
