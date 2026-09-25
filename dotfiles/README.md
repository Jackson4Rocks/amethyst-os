# Amethyst OS AURORA Dotfiles

The reference desktop configuration for Amethyst OS.

## Design

The setup intentionally keeps the desktop small and cohesive:

- Hyprland for the compositor
- DankMaterialShell for the main shell
- Kitty for the terminal
- Fastfetch for the terminal welcome
- Zsh as the interactive shell
- Hyprpaper for wallpaper rendering
- Matugen for wallpaper-derived palettes
- Fuzzel for a lightweight application launcher
- Yazi for terminal file management

DankMaterialShell is already built with Quickshell, so AURORA avoids stacking a second bar/window shell on top of DMS.

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

Arrow-key focus / move / resize bindings are also provided.

## Wallpaper-driven color

Use:

    aos-wallpaper ~/Pictures/wallpapers/my-wallpaper.png

Matugen derives a dark palette from the image and renders the Amethyst theme files. Hyprpaper changes the live wallpaper through its IPC interface.

## Installation

    cd dotfiles
    bash scripts/install.sh

For the Amethyst OS ISO, copy these files into /etc/skel so every new live user receives the AURORA defaults.

## Notes

The Hyprland configuration targets the modern Lua-based configuration system used by Hyprland 0.55+.
