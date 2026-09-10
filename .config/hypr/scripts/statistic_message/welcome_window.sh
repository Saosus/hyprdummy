#!/bin/bash

DATA_DIR="$HOME/.config/hypr/scripts/statistic_message"
TODAY_SEC=$(date +%s)

<<<<<<< HEAD
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
=======
# Функция для расчёта дней из файла с датой
get_days() {
    local file="$1"
    if [[ ! -f "$file" ]]; then echo "0"; return; fi
    local start_date=$(cat "$file")
    local start_sec=$(date -d "$start_date" +%s 2>/dev/null)
    if [[ -z "$start_sec" ]]; then echo "Err"; return; fi
    echo $(( (TODAY_SEC - start_sec) / 86400 ))
}

# Функция для чтения рекорда
get_record() {
    local file="$1"
    if [[ -f "$file" ]] && [[ -s "$file" ]]; then
        local rec=$(cat "$file")
        if [[ "$rec" =~ ^[0-9]+$ ]]; then
            echo "$rec"
        else
            echo "0"
        fi
    else
        echo "0"
    fi
}

# Получаем текущие значения
s_count=$(get_days "$DATA_DIR/noSugar_reset_day")
f_count=$(get_days "$DATA_DIR/noFlour_reset_day")
bt_count=$(get_days "$DATA_DIR/tooLate_bedtime")
med_count=$(get_days "$DATA_DIR/meditation_reset_day")

# Получаем рекорды
s_record=$(get_record "$DATA_DIR/noSugar_record")
f_record=$(get_record "$DATA_DIR/noFlour_record")
bt_record=$(get_record "$DATA_DIR/tooLate_bedtime_record")
med_record=$(get_record "$DATA_DIR/meditation_record")

# Очистка экрана и приветствие
clear
cat "$DATA_DIR/greeting_message" | shuf -n 1 | figlet -f slant -c -t -k | pv -qL 400 | lolcat
echo "--------------------------------------------------------------------------------------------"
>>>>>>> 9d211cf (reinitialized repo)
sleep 1

echo "Твоя текущая статистика:" && sleep 0.5

<<<<<<< HEAD
# Проверка на ошибки парсинга
if [[ "$s_count" == "Err" || "$f_count" == "Err" ]]; then
    echo "Ошибка: В файлах данных должна быть дата (ГГГГ-ММ-ДД)!"
    exit 1
fi

echo "Дней без сахара: $s_count" && sleep 0.5
echo "Дней без мучного: $f_count" && sleep 0.5

# Hyprland UI tweaks
sleep 2

=======
# Проверка ошибок
if [[ "$s_count" == "Err" || "$f_count" == "Err" || "$bt_count" == "Err" ]]; then
    echo "❌ Ошибка: В одном из файлов с датой должен быть формат ГГГГ-ММ-ДД!"
    exit 1
fi

echo "🍬 Дней без сахара:    $s_count (рекорд: $s_record)" && sleep 0.5
echo "🍞 Дней без мучного:   $f_count (рекорд: $f_record)" && sleep 0.5
echo "😴 Лёг не позже 02:00: $bt_count (рекорд: $bt_record)" && sleep 0.5
echo "Не пропущено медитации: $med_count (рекорд: $med_record)" && sleep 0.5

sleep 2
>>>>>>> 9d211cf (reinitialized repo)
