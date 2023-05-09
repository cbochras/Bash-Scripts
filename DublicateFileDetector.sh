#!/bin/bash

echo "Enter the directory to search for duplicate files:"
read directory

# Find all files in the directory and its subdirectories
# and compute their MD5 checksums
md5sums=$(find "$directory" -type f -print0 | xargs -0 md5sum)

# Extract the MD5 checksums and file paths into two separate arrays
md5s=($(echo "$md5sums" | awk '{print $1}'))
files=($(echo "$md5sums" | awk '{print $2}'))

# Loop through the MD5 checksums and compare them
# to find duplicate files
declare -A duplicates
for i in "${!md5s[@]}"; do
    if [[ ${duplicates[${md5s[i]}]} ]]; then
        # If this MD5 has already been seen, mark it as a duplicate
        duplicates[${md5s[i]}]+="|${files[i]}"
    else
        # Otherwise, store the MD5 and file path
        duplicates[${md5s[i]}]="${files[i]}"
    fi
done

# Print out any duplicate files
for md5 in "${!duplicates[@]}"; do
    files=${duplicates[$md5]}
    num_files=$(echo $files | tr '|' ' ' | wc -w)
    if [ $num_files -gt 1 ]; then
        echo "Duplicate files with MD5 checksum $md5:"
        echo "$files"
        echo ""
    fi
done

echo "Do you want to delete or move the duplicate files? (delete/move/exit)"
read action

case $action in
    delete)
        for md5 in "${!duplicates[@]}"; do
            files=${duplicates[$md5]}
            num_files=$(echo $files | tr '|' ' ' | wc -w)
            if [ $num_files -gt 1 ]; then
                # Delete all but the first instance of the file
                echo "Deleting duplicate files with MD5 checksum $md5..."
                echo "$files" | tr '|' '\n' | tail -n +2 | xargs rm
                echo ""
            fi
        done
        ;;
    move)
        echo "Enter the directory to move the duplicate files to:"
        read dest_dir
        mkdir -p "$dest_dir"
        for md5 in "${!duplicates[@]}"; do
            files=${duplicates[$md5]}
            num_files=$(echo $files | tr '|' ' ' | wc -w)
            if [ $num_files -gt 1 ]; then
                echo "Moving duplicate files with MD5 checksum $md5 to $dest_dir..."
                echo "$files" | tr '|' '\n' | tail -n +2 | xargs -I{} mv {} "$dest_dir"
                echo ""
            fi
        done
        ;;
    *)
        echo "Exiting without taking any action."
        exit 0
        ;;
esac

echo "Done!"
