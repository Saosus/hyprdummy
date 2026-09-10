#!/bin/bash

# Define the battery path (check if BAT0 or BAT1 is correct for your system using `ls /sys/class/power_supply/`)
BATTERY_DIR="/sys/class/power_supply/BAT0"
# Define the notification threshold (e.g., 15%)
THRESHOLD=15
# Define how long to sleep between checks (in seconds)
SLEEP_TIME=300 #10 minutes

while true; do
    # Get battery level and status
    BAT_LVL=$(cat "$BATTERY_DIR/capacity")
    BAT_STATUS=$(cat "$BATTERY_DIR/status")

    if [ "$BAT_STATUS" == "Discharging" ] && [ "$BAT_LVL" -le "$THRESHOLD" ]; then
        notify-send --urgency=critical "BRAH, NEED PAWAH!" "Level: ${BAT_LVL}% remaining."
	mpv ~/media/sounds/flashback-one-piece.mp3 # Discharging sound effect
	powerprofilesctl set power-saver

        # Sleep for a longer period after notification to avoid spamming
        sleep 180 # 3 minutes
    else
	powerprofilesctl set balanced
        sleep "$SLEEP_TIME"
    fi
done

