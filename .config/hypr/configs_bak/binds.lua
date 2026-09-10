---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local fileManager = "kitty -e ranger"
local dispatcher = "kitty -e btop"

hl.bind(mainMod .. " + SHIFT + code:49", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

--Own scripts
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-changer.sh"))
hl.bind(mainMod .. " + code:49", hl.dsp.exec_cmd("hyprctl switchxkblayout at-translated-set-2-keyboard 0 && hyprlock"))

-- Exec-binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(dispatcher))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("wofi --show drun -b -a -C ~/.cache/wal/colors.css"))
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy"), {release = true, locked = true})
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/taking_screenshots.sh"), {release = true, locked = true})

hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "maximized"}))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.fullscreen({ mode = "fullscreen"}))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.layout("swapsplit"))    -- dwindle only
hl.bind(mainMod .. " + W", hl.dsp.window.pseudo())    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + j",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + k",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l",  hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + j",  hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + k",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false}))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + F",         hl.dsp.workspace.toggle_special("work"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.move({ workspace = "special:work" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

