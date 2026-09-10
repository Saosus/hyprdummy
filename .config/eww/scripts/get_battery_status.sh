#!/bin/bash

STATUS=$(cat /sys/class/power_supply/BAT*/status)
PERCENTAGE=$(cat /sys/class/power_supply/BAT*/capacity)

if [[ $STATUS = 'Charging' ]]; then 
        echo "󰂄"
        exit 0 
fi 

if [[ $PERCENTAGE -gt 90 ]]; then echo "󰁹" 
elif [[ $PERCENTAGE -gt 70 ]]; then echo "󰂁" 
elif [[ $PERCENTAGE -gt 50 ]]; then echo "󰁾" 
elif [[ $PERCENTAGE -gt 20 ]]; then echo "󰁼" 
elif [[ $PERCENTAGE -gt 0 ]]; then echo "󰁺" 
fi
