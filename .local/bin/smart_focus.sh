#target_space!/bin/bash
# smart_focus.sh
# Usage: ./smart_focus.sh <space_number>
# This script will focus the specified space within the current display.

# Get the current display index
spaces=$(yabai -m query --displays --display | jq '.spaces | .[0], .[-1]')
# shellcheck disable=SC2086
read -r first_space last_space <<< $spaces
desired_space="${1:-$first_space}"
target_space=$((first_space + desired_space - 1))

if [ "$target_space" -gt "$last_space" ]; then
    target_space=$last_space
fi

yabai -m space --focus "$target_space"
