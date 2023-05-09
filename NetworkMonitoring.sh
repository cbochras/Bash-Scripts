#!/bin/bash


# Define network interface to monitor
INTERFACE="eth0"

# Define interval for monitoring (in seconds)
INTERVAL=5

# Define path to log file
LOG_FILE="/var/log/network_monitor.log"

# Define function to check network activity
check_network_activity() {
    # Get current timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Get network usage statistics
    RX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    TX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
    TOTAL_BYTES=$((RX_BYTES + TX_BYTES))
    
    # Write statistics to log file
    echo "$TIMESTAMP - $INTERFACE: $TOTAL_BYTES bytes" >> $LOG_FILE
}

# Main loop
while true; do
    check_network_activity
    sleep $INTERVAL
done
