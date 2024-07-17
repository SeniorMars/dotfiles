#!/bin/bash
# cycle_swap.sh
# Usage: ./cycle_swap.sh next  # To swap the current window with the next window
#       ./cycle_swap.sh prev  # To swap the current window with the previous window

direction="${1:-next}"  # 'next' or 'prev', defaulting to 'next'

# Determine the starting window
if [ "$direction" == "prev" ]; then
    win=$(yabai -m query --windows --window last | jq '.id')
elif [ "$direction" == "next" ]; then
    win=$(yabai -m query --windows --window first | jq '.id')
else
    echo "Invalid direction: $direction. Use 'prev' or 'next'."
    exit 1
fi

# Swap the windows in the specified direction
while : ; do
    yabai -m window "$win" --swap "$direction" &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done

