#!/bin/bash
# Query lbdbq and save results to Mutt alias file

set -e

# Mutt aliases file to save results to
ALIASES="$HOME/.cache/mutt/aliases"

# Only save email addresses from $DOMAIN. Leave empty to save all email addresses
DOMAIN="rice.edu"

query_and_cache() {
    results=$(lbdbq "$@" 2>/dev/null)

    printf '%s\n' "$results"

    # Remove first line from results
    results=$(sed '1d' <<< "$results")

    # Format results like mutt aliases
    sed -E $'s/^([[:alnum:]_.]+)@([[:alnum:]_.]+)\t([[:alnum:] -]+)/alias \\1 \\1@\\2 (\\3)/' <<< "$results" | awk -v domain="$DOMAIN" '$3 ~ domain {$2=tolower($2);print}' >> "$ALIASES"

    # Sort and remove duplicates
    sort -u -o "$ALIASES" "$ALIASES"

}

query_and_cache "$@"
