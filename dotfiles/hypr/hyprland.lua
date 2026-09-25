-- Amethyst OS AURORA
-- Minimal Hyprland setup for Hyprland 0.55+ / Lua configuration.

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 12,
    border_size = 2,
    layout = "dwindle",
    resize_on_border = true,
    allow_tearing = false,
  },

  decoration = {
    rounding = 12,
    active_opacity = 0.98,
    inactive_opacity = 0.94,
    fullscreen_opacity = 1.0,
    shadow = {
      enabled = true,
      range = 20,
      render_power = 3,
    },
    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      new_optimizations = true,
      xray = false,
      vibrancy = 0.12,
    },
  },

  dwindle = {
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
  },

  input = {
    kb_layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
    accel_profile = "adaptive",
    touchpad = {
      natural_scroll = true,
      tap_to_click = true,
      tap_and_drag = true,
      disable_while_typing = true,
    },
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    focus_on_activate = true,
    enable_swallow = false,
    initial_workspace_tracking = 1,
  },

  xwayland = {
    force_zero_scaling = false,
  },
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "auto",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.curve("aosEase", {
  type = "bezier",
  points = { { 0.16, 1.0 }, { 0.3, 1.0 } },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "aosEase", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "aosEase", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6, bezier = "aosEase", style = "popin 92%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 7, bezier = "aosEase" })
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "aosEase" })
hl.animation({ leaf = "layers", enabled = true, speed = 7, bezier = "aosEase", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "aosEase", style = "slidefade" })

local terminal = "kitty"
local file_manager = "kitty -- yazi"
local launcher = "fuzzel"
local main_mod = "SUPER"

local function exec(command)
  return hl.dsp.exec_cmd(command)
end

hl.bind(main_mod .. " + RETURN", exec(terminal), { description = "Open terminal" })
hl.bind(main_mod .. " + E", exec(file_manager), { description = "Open file manager" })
hl.bind(main_mod .. " + D", exec(launcher), { description = "Open application launcher" })
hl.bind(main_mod .. " + Q", hl.dsp.window.kill(), { description = "Close focused window" })
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.window.kill(), { description = "Kill focused window" })

hl.bind(main_mod .. " + SHIFT + M", exec("loginctl terminate-user \"$USER\""), { description = "Log out" })
hl.bind(main_mod .. " + SHIFT + R", exec("hyprctl reload"), { description = "Reload Hyprland" })
hl.bind(main_mod .. " + SHIFT + W", exec("aos-wallpaper"), { description = "Choose wallpaper and recolor theme" })

hl.bind(main_mod .. " + LEFT", exec("hyprctl dispatch movefocus l"), { description = "Focus left" })
hl.bind(main_mod .. " + RIGHT", exec("hyprctl dispatch movefocus r"), { description = "Focus right" })
hl.bind(main_mod .. " + UP", exec("hyprctl dispatch movefocus u"), { description = "Focus up" })
hl.bind(main_mod .. " + DOWN", exec("hyprctl dispatch movefocus d"), { description = "Focus down" })

hl.bind(main_mod .. " + SHIFT + LEFT", exec("hyprctl dispatch movewindow l"), { description = "Move window left" })
hl.bind(main_mod .. " + SHIFT + RIGHT", exec("hyprctl dispatch movewindow r"), { description = "Move window right" })
hl.bind(main_mod .. " + SHIFT + UP", exec("hyprctl dispatch movewindow u"), { description = "Move window up" })
hl.bind(main_mod .. " + SHIFT + DOWN", exec("hyprctl dispatch movewindow d"), { description = "Move window down" })

hl.bind(main_mod .. " + CTRL + LEFT", exec("hyprctl dispatch resizeactive -40 0"), { description = "Resize left" })
hl.bind(main_mod .. " + CTRL + RIGHT", exec("hyprctl dispatch resizeactive 40 0"), { description = "Resize right" })
hl.bind(main_mod .. " + CTRL + UP", exec("hyprctl dispatch resizeactive 0 -40"), { description = "Resize up" })
hl.bind(main_mod .. " + CTRL + DOWN", exec("hyprctl dispatch resizeactive 0 40"), { description = "Resize down" })

for i = 1, 9 do
  hl.bind(main_mod .. " + " .. i, exec("hyprctl dispatch workspace " .. i), {
    description = "Switch to workspace " .. i,
  })
  hl.bind(main_mod .. " + SHIFT + " .. i, exec("hyprctl dispatch movetoworkspace " .. i), {
    description = "Move window to workspace " .. i,
  })
end

hl.bind(main_mod .. " + 0", exec("hyprctl dispatch workspace 10"), { description = "Switch to workspace 10" })
hl.bind(main_mod .. " + SHIFT + 0", exec("hyprctl dispatch movetoworkspace 10"), { description = "Move window to workspace 10" })

hl.bind(main_mod .. " + S", exec("hyprctl dispatch togglespecialworkspace magic"), {
  description = "Toggle scratchpad",
})
hl.bind(main_mod .. " + SHIFT + S", exec("hyprctl dispatch movetoworkspace special:magic"), {
  description = "Send window to scratchpad",
})

hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Toggle fullscreen" })
hl.bind(main_mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(main_mod .. " + P", exec("hyprctl dispatch pseudo"), { description = "Toggle pseudotile" })
hl.bind(main_mod .. " + TAB", exec("hyprctl dispatch cyclenext"), { description = "Cycle windows" })
hl.bind(main_mod .. " + SHIFT + TAB", exec("hyprctl dispatch cyclenext prev"), { description = "Cycle windows backwards" })

hl.bind("", "XF86AudioRaiseVolume", exec("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("", "XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("", "XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("", "XF86MonBrightnessUp", exec("brightnessctl set 5%+"))
hl.bind("", "XF86MonBrightnessDown", exec("brightnessctl set 5%-"))

hl.bind("", "XF86AudioPlay", exec("playerctl play-pause"))
hl.bind("", "XF86AudioNext", exec("playerctl next"))
hl.bind("", "XF86AudioPrev", exec("playerctl previous"))

hl.bind("", "PRINT", exec("sh -lc 'grim -g \"$(slurp)\" - | wl-copy'"), {
  description = "Screenshot region to clipboard",
})
hl.bind(main_mod .. " + PRINT", exec("sh -lc 'grim - | wl-copy'"), {
  description = "Screenshot full screen to clipboard",
})

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("qs -c amethyst")
end)
