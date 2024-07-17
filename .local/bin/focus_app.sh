#!/bin/bash

# Check if the application name is provided
if [ -z "$1" ]; then
  exit 1
fi

app_name="$1"

# Find the window ID of the first instance of the specified application
app_window=$(yabai -m query --windows | jq -r --arg app_name "$app_name" 'map(select(.app == $app_name))[0].id')

# Focus on the application window if it exists
if [ -n "$app_window" ]; then
  yabai -m window --focus "$app_window"
fi
