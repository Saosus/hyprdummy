--### AUTOSTART ###

--# Autostart necessary processes (like notifications daemons, status bars, etc.)
--# Or execute your favorite apps at launch like this:
--
--# exec-once = $terminal
--# exec-once = nm-applet &
--# exec-once = waybar & hyprpaper & firefox
--
--## Used hyprshade earlier, saved it just for save
--#exec-once = exec-once = dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
--#exec = hyprshade auto
local startsound = "sh -c 'mpv \"$(find ~/media/start-sounds -type f | shuf -n 1)\" --volume=50 --no-terminal --no-video'"

hl.on("hyprland.start", function () 
   hl.exec_cmd("udiskie -t &")
   hl.exec_cmd("awww-daemon")
 --  hl.exec_cmd("mpvpaper -o '--loop-playlist --input-ipc-server=/tmp/mpvsocket shuffle' ALL ~/media/wallps/animates -n 180")
   hl.exec_cmd("eww open topbar")
   hl.exec_cmd("sh -c topbar")
   hl.exec_cmd("hyprlauncher -d")
   hl.exec_cmd("hypridle &")
   hl.exec_cmd("hyprsunset &")
   hl.exec_cmd(startsound)
   hl.exec_cmd("~/.config/hypr/scripts/low_battery_notify.sh")
  -- hl.exec_cmd("/usr/local/bin/mpvpaper-stop -t 1000 -f -v")
 --  hl.dispatch("exec", "[float; size 512 640] kitty --class welcome-term bash -c ~/.config/hypr/scripts/statistic_message/welcome_window.sh")
end)

--##системное
--exec-once = udiskie -t &
--
--##Обойчики
--exec-once = awww-daemon 
--#exec-once = awww img $wallpaperfir --transition-fps 144 --transition-duration 1 --transition-type fade --transition-bezier .07,.82,.17,1 &&  walrs -q -i $wallpaperfir -b 20 -s 120 -W
--#exec-once = walrs -q -i $wallpaperfir -W
--
--##Виджетики
--#exec-once = eww daemon 
--exec-once = eww open topbar
--#exec-once = ~/.config/eww/scripts/workspace.sh
--
--##Уау
--exec-once = sh -c $startsound
--exec-once = hyprctl dispatch exec "[float; size 512 640; left]" -- kitty --class welcome-term bash -c "~/.config/hypr/scripts/statistic_message/welcome_window.sh"
--
--##Экосистемка хайпы
--exec-once = hyprlauncher -d
--exec-once = hypridle &
--exec-once = hyprsunset &
--
--
--exec-once = ~/.config/hypr/scripts/low_battery_notify.sh
--
