#!/bin/bash

while true; do

    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2+$4}')

    mem_usage=$(free | awk 'NR==2{printf "%.2f\n", $3/$2*100}')

    disk_usage=$(df -h / | awk 'NR==2{print $5}')

    echo "CPU usage: $cpu_usage%"
    echo "Memory usage: $mem_usage%"
    echo "Disk usage: $disk_usage"

    sleep 5
done
