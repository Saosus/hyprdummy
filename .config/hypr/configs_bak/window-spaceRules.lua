-- ### WINDOWS AND WORKSPACES ###


local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

--#### MY CONFIGS
hl.window_rule({
    name  = "kitty-opacity",
    match = { class = "kitty" },
    opacity = "0.85 override 0.50 override 0.75 override"
})

hl.window_rule({
    name  = "firefox-opacity",
    match = { class = "firefox" },
    opacity = "1.00 override 0.80 override 1.00 override",
})

hl.window_rule({
    name  = "kvm-opacity",
    match = { class = "virt-manager" },
    opacity = "1.00 override 1.00 override 1.00 override",
})

hl.layer_rule({ match = { namespace = "notifications" }, animation = "slidefade right"})
hl.layer_rule({ match = { namespace = "awww-daemon" }, animation = "popin 75%"})
