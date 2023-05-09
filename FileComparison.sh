#!/bin/bash

if [[ ! -f $1 || ! -f $2 ]]; then
    echo "Usage: $0 file1 file2"
    exit 1
fi

# Compare files and highlight differences
diff --color=auto $1 $2
