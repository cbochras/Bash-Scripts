#!/bin/bash

# URL to monitor
url="https://example.com"

# Loop indefinitely
while true; do
    # Get response code and time using curl
    response=$(curl -s -w "%{http_code} %{time_total}\n" -o /dev/null $url)

    # Get timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # Output result to log file
    echo "$timestamp - $response" >> website.log

    # Wait for 10 seconds before checking again
    sleep 10
done
