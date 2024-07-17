#!/bin/bash

# Check if the application name is provided
if [ -z "$1" ]; then
  echo "Please provide an application name."
  exit 1
fi

app_name="$1"

# Find the window IDs of the specified application, sorted
app_windows=$(yabai -m query --windows | jq -r --arg app_name "$app_name" '.[] | select(.app == $app_name) | .id' | sort -n)

# Convert the list of window IDs to an array
IFS=$'\n' read -d '' -r -a app_windows_array <<< "$app_windows"

# Check if there are any windows of the application
if [ ${#app_windows_array[@]} -eq 0 ]; then
  echo "$app_name is not running."
  exit 1
fi

# Get the currently focused window ID and its application name
current_window=$(yabai -m query --windows --window | jq -r '.id')

# Find the index of the currently focused window in the array, if it belongs to the specified application
current_index=-1
for i in "${!app_windows_array[@]}"; do
  if [ "${app_windows_array[$i]}" == "$current_window" ]; then
    current_index=$i
    break
  fi
done

# Calculate the index of the next window to focus
if [ "$current_index" -eq -1 ]; then
  next_index=0
else
  next_index=$(( (current_index + 1) % ${#app_windows_array[@]} ))
fi

# Focus on the next window
yabai -m window --focus "${app_windows_array[$next_index]}"
