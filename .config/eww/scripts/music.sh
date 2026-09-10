#!/bin/bash
base_dir="$HOME/.config/eww/"
image_file="${base_dir}image.jpg"
firefox_image="$HOME/.config/mozilla/firefox/firefox-mpris/*.png"

playerctl metadata --player=firefox -F -f '{{playerName}}|{{title}}|{{artist}}|{{mpris:artUrl}}|{{status}}|{{mpris:length}}' | while IFS='|' read -r name title artist artUrl status length; do
    if [[ -n "$length" && "$length" =~ ^[0-9]+$ ]]; then
        len_sec=$(( (length + 500000) / 1000000 ))
        mins=$((len_sec / 60))
        secs=$((len_sec % 60))
        lengthStr=$(printf "%d:%02d" "$mins" "$secs")
    else
        len_sec=""
        lengthStr=""
    fi
        # Handle album art
    if [[ "$artUrl" =~ ^https?:// ]]; then
        # Download remote image
        tmp_image="${image_file}.tmp"
        if wget -q -O "$tmp_image" "$artUrl"; then
            mv "$tmp_image" "$image_file"
        else
            rm -f "$tmp_image"
            cp "$fallback_image" "$image_file"
        fi

    elif [[ "$artUrl" =~ ^file:// ]]; then
        # Extract local path from file:// URL
        file_path="${artUrl#file://}"
        if [[ -f "$file_path" ]]; then
            tmp_image="${image_file}.tmp"
            if cp "$file_path" "$tmp_image"; then
                mv "$tmp_image" "$image_file"
            else
                rm -f "$tmp_image"
                cp "$fallback_image" "$image_file"
            fi
        else
            cp "$fallback_image" "$image_file"
        fi

    else
        # Fallback for empty or unsupported URLs
        cp "$fallback_image" "$image_file"
    fi

    jq -n -c \
        --arg name "$name" \
        --arg title "$title" \
        --arg artist "$artist" \
        --arg artUrl "$image_file" \
        --arg status "$status" \
        --arg length "$len_sec" \
        --arg lengthStr "$lengthStr" \
        '{name: $name, title: $title, artist: $artist, thumbnail: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}'
done
