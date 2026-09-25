-- ============================================================
-- AMETHYST OS AURORA
-- Hyprland 0.55+ Lua configuration
-- ============================================================

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("sh -lc 'command -v dms >/dev/null 2>&1 && dms run || true'")
end)

local terminal = "kitty"

-- ------------------------------------------------------------
-- MONITOR
-- ------------------------------------------------------------

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- ------------------------------------------------------------
-- ENVIRONMENT
-- ------------------------------------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- ------------------------------------------------------------
-- LOOK & FEEL
-- ------------------------------------------------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        rounding = 12,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            new_optimizations = true,
        },
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    },

    dwindle = {
        preserve_split = true,
    },

    cursor = {
        no_hardware_cursors = false,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

-- ------------------------------------------------------------
-- ANIMATIONS
-- ------------------------------------------------------------

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", {
    type = "bezier",
    points = {
        {0.23, 1},
        {0.32, 1},
    },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = {
        {0.65, 0.05},
        {0.36, 1},
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 8,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    bezier = "easeOutQuint",
    style = "popin 85%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "popin 85%",
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = "easeInOutCubic",
    style = "fade",
})

-- ------------------------------------------------------------
-- STARTUP
-- ------------------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("sh -lc 'command -v dms >/dev/null 2>&1 && dms run || true'")
end)

-- ------------------------------------------------------------
-- KEYBINDS
-- ------------------------------------------------------------

local mod = "SUPER"

-- Terminal
hl.bind(
    mod .. " + RETURN",
    hl.dsp.exec_cmd(terminal)
)

-- Close active window
hl.bind(
    mod .. " + Q",
    hl.dsp.window.close()
)

-- Exit Hyprland
hl.bind(
    mod .. " + M",
    hl.dsp.exec_cmd("hyprctl dispatch exit")
)

-- Move focus
hl.bind(
    mod .. " + LEFT",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    mod .. " + RIGHT",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    mod .. " + UP",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    mod .. " + DOWN",
    hl.dsp.focus({ direction = "down" })
)

-- Float toggle
hl.bind(
    mod .. " + V",
    hl.dsp.window.float({ action = "toggle" })
)

-- Pseudo
hl.bind(
    mod .. " + P",
    hl.dsp.window.pseudo()
)

-- Toggle split
hl.bind(
    mod .. " + J",
    hl.dsp.layout("togglesplit")
)

-- Workspaces 1-9 and 0
for i = 1, 10 do
    local key = tostring(i % 10)

    hl.bind(
        mod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Scroll through workspaces
hl.bind(
    mod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    mod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)

-- Mouse window movement
hl.bind(
    mod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- ------------------------------------------------------------
-- MEDIA / HARDWARE KEYS
-- ------------------------------------------------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true }
)

-- ------------------------------------------------------------
-- WINDOW RULES
-- ------------------------------------------------------------

hl.window_rule({
    name = "suppress-maximize",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "xwayland-drag-fix",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
