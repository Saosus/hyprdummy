#!/bin/bash

function wp_is_new () {
	local new_wallpaper="$1"

	if [ -z "$new_wallpaper" ];
	then
		exit 1
	fi

	local CURRENT_WALLPAPER=$(swww query | grep -oP 'image: \K.*' | head -1)

	if [ "$1" = "$CURRENT_WALLPAPER" ]
	then
		echo "regenerate"
	else
		echo "$1"
	fi
}		

# Директория с обоями
<<<<<<< HEAD
WALLPAPER_DIR="/home/cppyli/Media/Wallpapers/Solyanka"
=======
WALLPAPER_DIR="/home/cppyli/media/wallps/solyanka"
>>>>>>> 9d211cf (reinitialized repo)

# Проверяем, существует ли директория
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Ошибка: директория $WALLPAPER_DIR не найдена."
    exit 1
fi

# Ищем случайное изображение
WALLPAPER=""
FLAG="regenerate"

while [ "$FLAG" = "regenerate" ]
do
	WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
	
	# Проверяем, найден ли файл
	if [ -z "$WALLPAPER" ]; then
    		notify-send "Ошибка: в директории нет изображений (jpg, png, jpeg)."
    		exit 1
	fi
	
	#Проверка, что обои не текущие
	if [ $(wp_is_new $WALLPAPER) != "regenerate" ]
	then
		FLAG=""
	else
		continue
	fi
done

# Меняем обои 
<<<<<<< HEAD
swww img "$WALLPAPER" --transition-bezier 0.25,0.46,0.45,0.94 --transition-type any --transition-fps 60 --transition-duration 1.3


#Звуковой эффект
mpv ~/Media/Sounds/haki1.mp3 --volume=30 --no-video --no-terminal & 
=======
awww img "$WALLPAPER" --transition-bezier 0.25,0.46,0.45,0.94 --transition-type any --transition-fps 60 --transition-duration 1.3


#Звуковой эффект
mpv ~/media/sounds/haki1.mp3 --volume=30 --no-video --no-terminal & 
>>>>>>> 9d211cf (reinitialized repo)

sleep 0.4 # задержка для синхронности с walrs

# Меняем цветовую схему через walrs
walrs -q -i "$WALLPAPER" -b 20 -s 150 -W 

<<<<<<< HEAD
#меняем схему eww
/home/cppyli/Documents/githubClones/eww/target/release/eww reload --no-daemonize
=======
#обновляем hyprland цвета
hyprctl reload

#меняем схему eww
eww reload --no-daemonize --force-wayland
>>>>>>> 9d211cf (reinitialized repo)

walogram # смена темы telegram 

# перезапускаем службу уведомлений
makoctl reload 
<<<<<<< HEAD

=======
>>>>>>> 9d211cf (reinitialized repo)
