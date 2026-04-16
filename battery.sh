#!/data/data/com.termux/files/usr/bin/bash

#!/bin/bash

# 1. Get battery percentage from termux-battery-status
# We use jq to parse the JSON output specifically for the "percentage" field
PERCENT=$(termux-battery-status | jq -r '.percentage')

# 2. Calculate drained dots (top-down drain)
# Total dots = 100. If battery is 85%, 15 dots are empty at the top.
DRAINED=$((100 - PERCENT))

# 3. Generate 10x10 grid
for row in {1..10}; do
    for col in {1..10}; do
        # Calculate current dot index (1-100)
        INDEX=$(( (row - 1) * 10 + col ))
        
        if [ $INDEX -le $DRAINED ]; then
            echo -n "○ " # Empty dot (drained from top)
        else
            echo -n "● " # Filled dot
        fi
    done
    echo "" # New line after every 10 dots
done
