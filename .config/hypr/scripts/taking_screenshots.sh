#!/bin/bash

SCREENSHOT_NAME=Screenshot-$(date +%F_%T).png
SCREENSHOT_DIR=~/media/Screenshots
SCREENSHOT_SAVE="$SCREENSHOT_DIR/$SCREENSHOT_NAME"

# Создаем папку, если её нет
mkdir -p "$SCREENSHOT_DIR"

# 1. Сначала пробуем получить область через slurp
GEOM=$(slurp)

# 2. Проверяем, не пуст ли геометрический замер (на случай Escape)
if [[ -n "$GEOM" ]]; then
    # Делаем скриншот, копируем в буфер и ОДНОВРЕМЕННО сохраняем в файл
    # Используем 'tee', чтобы данные пошли и в файл, и в wl-copy
    grim -g "$GEOM" - | tee "$SCREENSHOT_SAVE" | wl-copy

    # Проверяем, что файл действительно создался и он не пустой
    if [[ -s "$SCREENSHOT_SAVE" ]]; then
        mpv ~/media/sounds/transponder-snail-accept-call.mp3 --volume=50 --no-terminal &
        notify-send --transient --urgency=low "SCREENSHOT TAKEN, BRAH!" "Saved to $SCREENSHOT_SAVE" -t 3000
    else
        notify-send --transient --urgency=low "IT'S EMPTY, BRAH" "SCREENSHOT NOT TAKEN" -t 3000
        rm -f "$SCREENSHOT_SAVE" # Удаляем пустой файл, если он создался
    fi
else
    # Сюда попадем, если нажали Escape во время выбора области
    notify-send --transient --urgency=low "CANCELLED" "Selection cancelled" -t 2000
fi

