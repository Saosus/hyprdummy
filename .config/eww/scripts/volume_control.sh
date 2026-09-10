#!/bin/bash
# Использование: ./volume_control.sh <up|down|mute|set> [value]

case "$1" in
    up)
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+
        ;;
    down)
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    set)
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "$2%"
        ;;
esac

# Обновляем eww сразу
eww update volume_info="$(~/.config/eww/scripts/get_volume.sh)"
