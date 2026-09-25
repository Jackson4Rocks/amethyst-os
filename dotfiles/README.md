# Calypso Linux — Optional Hyprland configuration

This directory contains the current optional Hyprland configuration shipped with the project. It is not required for the main KDE Plasma installation and may change independently of the base Calypso desktop.

## Design

The current Hyprland configuration uses a small desktop stack:

- Hyprland — compositor
- **Quickshell — desktop shell**
- Kitty — terminal
- Fastfetch — terminal welcome
- Zsh — interactive shell
- Hyprpaper — wallpaper rendering
- Matugen — wallpaper-derived colors
- Fuzzel — lightweight app launcher
- Yazi — terminal file manager

Quickshell configs live in `~/.config/quickshell/<name>`; the current project configuration uses the `aurora` profile when those optional files are installed.

## Shell design

The default shell is a floating, centered top panel with:

- Calypso branding
- live Hyprland workspace pills
- active-window title
- clock
- wallpaper-derived colors

Quickshell provides native Hyprland workspace access and can create one panel per connected monitor.

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

    calypso-wallpaper ~/Pictures/wallpapers/my-wallpaper.png

Matugen generates the Quickshell theme, Kitty colors, and Fuzzel colors from the wallpaper. Quickshell watches its config files for changes, so the shell can update when the generated `Theme.qml` changes.

## Installation

    cd dotfiles
    bash scripts/install.sh

For the Calypso Linux ISO, these files are available as an optional Hyprland configuration.

## Notes

The Hyprland configuration targets the Lua-based configuration system used by current Hyprland releases.

Quickshell is intentionally treated as the framework for the Calypso shell rather than relying on another full desktop shell. Its current documentation describes it as a toolkit for building bars, widgets, notifications, lock screens, and other desktop components.


## Desktop profiles

| Desktop | Role |
| --- | --- |
| KDE Plasma | Main Calypso desktop |
| Hyprland | Optional alternative profile |

The installer installs the selected desktop. The configuration in this directory is applied only to Hyprland and is not required for KDE Plasma.