#!/bin/bash

DATA_DIR="$HOME/.config/hypr/scripts/statistic_message"
TODAY_SEC=$(date +%s)

# Функция для расчета дней 
get_days() {
    local file="$1"
    if [[ ! -f "$file" ]]; then echo "0"; return; fi
    
    local start_date=$(cat "$file")
    # Преобразуем дату старта в секунды
    local start_sec=$(date -d "$start_date" +%s 2>/dev/null)
    
    if [[ -z "$start_sec" ]]; then echo "Err"; return; fi
    
    # Считаем разницу (секунды / 86400)
    echo $(( (TODAY_SEC - start_sec) / 86400 ))
}

# Если хочешь сбросить счетчик — просто сделай: date +%F > путь_к_файлу
s_count=$(get_days "$DATA_DIR/noSugar_reset_day")
f_count=$(get_days "$DATA_DIR/noFlour_reset_day")

clear
cat $DATA_DIR/greeting_message | shuf -n 1 | figlet -f slant -c -t -k | pv -qL 400 | lolcat 
echo "---------------------------------------------------------------------------------------------"
sleep 1

echo "Твоя текущая статистика:" && sleep 0.5

# Проверка на ошибки парсинга
if [[ "$s_count" == "Err" || "$f_count" == "Err" ]]; then
    echo "Ошибка: В файлах данных должна быть дата (ГГГГ-ММ-ДД)!"
    exit 1
fi

echo "Дней без сахара: $s_count" && sleep 0.5
echo "Дней без мучного: $f_count" && sleep 0.5

# Hyprland UI tweaks
sleep 2

