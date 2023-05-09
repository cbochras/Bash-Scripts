#!/bin/bash

echo "Enter the path to the log file:"
read logfile

echo "Enter the event or error to search for:"
read search_term

count=$(grep -c "$search_term" "$logfile")

echo "Occurrences of '$search_term': $count"
echo "Matching lines:"
grep "$search_term" "$logfile"


