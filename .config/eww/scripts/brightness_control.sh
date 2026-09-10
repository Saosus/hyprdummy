#!/bin/bash
# Использование: ./volume_control.sh <up|down|mute|set> [value]

case "$1" in
    up)
        brightnessctl set 2%+
        ;;
    down)
        brightnessctl set 2%-
        ;;
    *)
        if pgrep -x "hyprsunset" > /dev/null; then
            pkill -x hyprsunset
        else
            hyprsunset & disown
        fi
        ;;
esac

# Обновляем eww сразу
eww update brightness_info="$(~/.config/eww/scripts/get_brightness.sh)"
