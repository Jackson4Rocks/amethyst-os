# Amethyst OS AURORA Dotfiles

The reference desktop configuration for Amethyst OS.

## Design

AURORA is intentionally built as a small, custom desktop stack:

- Hyprland — compositor
- **Quickshell — desktop shell**
- Kitty — terminal
- Fastfetch — terminal welcome
- Zsh — interactive shell
- Hyprpaper — wallpaper rendering
- Matugen — wallpaper-derived colors
- Fuzzel — lightweight app launcher
- Yazi — terminal file manager

Quickshell configs live in `~/.config/quickshell/<name>`; AURORA uses the named `amethyst` config and starts it with `qs -c amethyst`. citeturn912860search2turn362347search1

## Shell design

The default shell is a floating, centered top panel with:

- AURORA branding
- live Hyprland workspace pills
- active-window title
- clock
- wallpaper-derived colors

Quickshell provides native Hyprland workspace access and can create one panel per connected monitor. citeturn893622search2turn362347search1

## Keybinds

- SUPER + Enter — terminal
- SUPER + D — application launcher
- SUPER + E — file manager
- SUPER + Q — close window
- SUPER + F — fullscreen
- SUPER + Shift + Space — toggle floating
- SUPER + Tab — cycle windows
- SUPER + 1..0 — workspaces
- SUPER + Shift + 1..0 — move window to workspace
- SUPER + Shift + W — wallpaper picker + recolor
- SUPER + Shift + R — reload Hyprland
- Print — region screenshot
- SUPER + Print — full-screen screenshot

Arrow-key focus, move, and resize bindings are also provided.

## Wallpaper-driven color

Use:

    aos-wallpaper ~/Pictures/wallpapers/my-wallpaper.png

Matugen generates the Quickshell theme, Kitty colors, and Fuzzel colors from the wallpaper. Quickshell watches its config files for changes, so the shell can update when the generated `Theme.qml` changes. citeturn362347search1

## Installation

    cd dotfiles
    bash scripts/install.sh

For the Amethyst OS ISO, place the same files into `/etc/skel` so new users receive the AURORA defaults.

## Notes

The Hyprland configuration targets the Lua-based configuration system used by current Hyprland releases. citeturn133000search3turn133000search5

Quickshell is intentionally treated as the framework for the Amethyst shell rather than relying on another full desktop shell. Its current documentation describes it as a toolkit for building bars, widgets, notifications, lock screens, and other desktop components. citeturn764349search0
