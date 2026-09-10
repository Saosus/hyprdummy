#!/bin/bash

DATA_DIR="$HOME/.config/hypr/scripts/statistic_message"
TODAY=$(date +%F)
TODAY_SEC=$(date +%s)

usage() {
    echo "Использование: $0 {sugar|flour|bedtime}"
    exit 1
}

# Проверка аргументов
if [ $# -ne 1 ]; then
    usage
fi

case "$1" in
    sugar)
        reset_file="noSugar_reset_day"
        record_file="noSugar_record"
        ;;
    flour)
        reset_file="noFlour_reset_day"
        record_file="noFlour_record"
        ;;
    bedtime)
        reset_file="tooLate_bedtime"
        record_file="tooLate_bedtime_record"
        ;;
    meditation)
        reset_file="meditation_reset_day"
        record_file="medtitation_record"
        ;;
    *)
        usage
        ;;
esac

reset_path="$DATA_DIR/$reset_file"
record_path="$DATA_DIR/$record_file"

# Функция вычисления количества дней из файла с датой
get_current_days() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        echo 0
        return
    fi
    local date_str=$(cat "$file")
    local date_sec=$(date -d "$date_str" +%s 2>/dev/null)
    if [[ -z "$date_sec" ]]; then
        echo 0
        return
    fi
    echo $(( (TODAY_SEC - date_sec) / 86400 ))
}

# Текущее значение до сброса
current_days=$(get_current_days "$reset_path")

# Чтение текущего рекорда
if [[ -f "$record_path" ]] && [[ -s "$record_path" ]]; then
    record=$(cat "$record_path")
    if ! [[ "$record" =~ ^[0-9]+$ ]]; then
        record=0
    fi
else
    record=0
fi

# Обновление рекорда при необходимости
if [[ "$current_days" -gt "$record" ]]; then
    echo "$current_days" > "$record_path"
    echo "🎉 Новый рекорд! $current_days дней."
fi

# Сброс даты
echo "$TODAY" > "$reset_path"
echo "✅ Сброс выполнен. Дата обновлена на $TODAY."
