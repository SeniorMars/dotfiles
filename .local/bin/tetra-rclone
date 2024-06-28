#!/bin/bash
SOURCE="$HOME"
DEST="box:tetra_backup"
EXCLUDE_FILE="/Users/charlie/.config/rclone/exclude_backup"

/opt/homebrew/bin/brew list > ~/.local/share/backup/brew_list.txt

/opt/homebrew/bin/flock -n /tmp/tetra_backup.lock /opt/homebrew/bin/rclone sync --update --verbose --transfers 30 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 30s --exclude-from "$EXCLUDE_FILE" --delete-excluded "$SOURCE" "$DEST"
