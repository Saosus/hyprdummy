--### INPUT ###

--# https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

--# See https://wiki.hypr.land/Configuring/Gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = "special",
    workspace_name = "magic"
})

hl.gesture({
    fingers = 3,
    direction = "up",
    action = "special",
    workspace_name = "work"
})

hl.gesture({ fingers = 4, direction = "down", action = "close" })
hl.gesture({ fingers = 4, direction = "up", action = "fullscreen", mode = "maximize" })

--# Example per-device config
--# See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
hl.device ({
    name = "syn1b8b:00-06cb:ce24-touchpad",
    sensitivity = 0.2
})
