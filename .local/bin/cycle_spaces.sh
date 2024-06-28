#!/bin/bash
# cycle_spaces.sh
# Usage: ./cycle_spaces.sh next  # To move to the next space
#        ./cycle_spaces.sh prev  # To move to the previous space

direction="${1:-next}"  # 'next' or 'prev', defaulting to 'next'

# Get the current display's focus status and its spaces
focused_display=$(yabai -m query --displays --display)
spaces=$(echo "$focused_display" | jq '.spaces[]')
current_space=$(yabai -m query --spaces --space | jq '.index')
first_space=$(echo "$spaces" | head -n 1)
last_space=$(echo "$spaces" | tail -n 1)

# Calculate next or previous index
if [ "$direction" == "next" ]; then
    new_space=$((current_space + 1))
    if [ "$new_space" -gt "$last_space" ]; then
        new_space=$first_space
    fi
elif [ "$direction" == "prev" ]; then
    new_space=$((current_space - 1))
    if [ "$new_space" -lt "$first_space" ]; then
        new_space=$last_space
    fi
fi

# Focus the new space
yabai -m space --focus "$new_space"
