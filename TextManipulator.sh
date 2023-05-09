#!/bin/bash

echo "Enter the filename to manipulate:"
read filename

echo "What operation would you like to perform on the file?"
echo "1. Convert text to uppercase"
echo "2. Convert text to lowercase"
echo "3. Remove duplicate lines"
echo "4. Count lines in file"
read operation

case $operation in
  1)
    tr '[:lower:]' '[:upper:]' < "$filename" > "$filename.upper"
    echo "Text converted to uppercase and saved as $filename.upper"
    ;;
  2)
    tr '[:upper:]' '[:lower:]' < "$filename" > "$filename.lower"
    echo "Text converted to lowercase and saved as $filename.lower"
    ;;
  3)
    sort -u < "$filename" > "$filename.nodupes"
    echo "Duplicate lines removed and saved as $filename.nodupes"
    ;;
  4)
    wc -l < "$filename" > "$filename.count"
    echo "Number of lines in file counted and saved as $filename.count"
    ;;
  *)
    echo "Invalid operation selected. Please try again."
    ;;
esac
