-- ### LOOK AND FEEL ###
-- # Refer to https://wiki.hypr.land/Configuring/Variables/
-- # https://wiki.hypr.land/Configuring/Variables/#general

local home = os.getenv("HOME")
local wal = dofile(home .. "/.cache/wal/colors-hyprland.lua")

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 12,
    
        border_size = 3,
    
        -- # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = {wal.color2, wal.color1}, angle = 75},
            inactive_border = wal.color0,
        },
        -- # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
    
        -- # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
    
        layout = "dwindle",
    },
    
    --# https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
        rounding = 10,
        rounding_power = 4,
    
        --# Change transparency of focused and unfocused windows
        active_opacity = 0.92,
        inactive_opacity = 0.7,
    
        shadow = {
            enabled = true,
            range = 8,
            render_power = 2,
            color = 0xee1a1a1a
        },
    
        --# https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 4,
            passes = 3,
    
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })                    
hl.curve("easeInOutBack",  { type = "bezier", points = { {0.68, -0.6},    {0.32, 1.6} } })  -- с более сильным "выбросом"
hl.curve("easeOutBack",    { type = "bezier", points = { {0.34, 1.35},    {0.64, 1.0} } })  -- с легким перелетом в конце (оживленно)
hl.curve("easeInBack",     { type = "bezier", points = { {0.36, 0},    {0.66, -0.56} } })  
hl.curve("easeOutQuad",    { type = "bezier", points = { {0.5, 1},    {0.89, 1} } })
hl.curve("easeOutExpo",    { type = "bezier", points = { {0.16, 1},    {0.3, 1} } })
hl.curve("easeInOutExpo",  { type = "bezier", points = { {0.87, 0},    {0.13, 1} } })
hl.curve("smoothStop",     { type = "bezier", points = { {0.11, 0.99},    {0.25, 1.01} } })
hl.curve("overshot",       { type = "bezier", points = { {0.7, 0.01},    {0.37, 1.06} } }) -- перелетает цель и возвращается

-- Default springs
--hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default"}) 
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "linear"})
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint"})
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 8.0,  bezier = "easeInOutBack", style = "slide top" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7.0,  bezier = "easeOutBack", style = "gnomed" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 8.0,  bezier = "easeOutBack", style = "gnomed"})
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 8.0,  bezier = "easeOutQuint"})
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 5.1,  bezier = "easeOutQuint"})
hl.animation({ leaf = "fadeSwitch",    enabled = true,  speed = 7.46, bezier = "easeOutQuint"})
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick"})
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint"})
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4.5,  bezier = "easeOutBack", style = "popin"})
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 4.0,  bezier = "easeInBack", style = "popin 1%"})
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 4.0,  bezier = "almostLinear"})
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 5.5,  bezier = "almostLinear"})
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4.50, bezier = "almostLinear", style = "fade"})
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 8.50, bezier = "easeOutQuint", style = "slide"})
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 8.50, bezier = "easeOutQuint", style = "slide"})
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7.00, bezier = "quick"})
hl.animation({ leaf = "specialWorkspace",    enabled = true,  speed = 4.50, bezier = "smoothStop", style = "slidevert 100%"})
hl.animation({ leaf = "specialWorkspaceIn",    enabled = true,  speed = 4.50, bezier = "almostLinear", style = "slide top"})
hl.animation({ leaf = "specialWorkspaceOut",    enabled = true,  speed = 3.50, bezier = "almostLinear", style = "slide bottom"})

