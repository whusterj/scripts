#!/bin/bash

# Step 1: List Heroku apps
apps=$(heroku apps -A)

# Step 2: Find apps with names containing 'prod'
prod_apps=$(echo "$apps" | grep 'prod' | awk '{print $1}')

# Step 3 and 4: Iterate over prod apps and get total releases
total_releases=0
for app in $prod_apps; do
    latest_version=$(heroku releases -a "$app" | grep -E '^v[0-9]+' | sort -rV | head -n 1 | awk '{print $1}' | sed 's/v//')
    if [ -n "$latest_version" ]; then
        total_releases=$((total_releases + latest_version))
        echo "App $app has version v$latest_version as the latest production release."
    else
        echo "No production releases found for app $app."
    fi
done

echo "Total production releases: $total_releases"
