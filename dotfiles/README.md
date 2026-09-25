# Calypso Linux — Optional Hyprland Configuration

This directory contains the **optional Hyprland configuration** maintained alongside Calypso Linux.

KDE Plasma remains the main Calypso desktop. **Hyprland is an optional, recommended window manager** for users who prefer a tiling, keyboard-driven workflow with deeper customization.

The Hyprland configuration is deliberately separated from the main KDE experience so it can evolve independently.

## What's included

The current configuration can include:

- **Hyprland** — compositor/window manager
- **Quickshell** — desktop shell layer used by the optional configuration
- **Kitty** — terminal
- **Fastfetch** — terminal system summary
- **Zsh** — interactive shell
- **Hyprpaper** — wallpaper handling
- **Matugen** — wallpaper-derived colors
- **Fuzzel** — application launcher
- **Yazi** — terminal file manager

These components describe the optional Hyprland environment; they are **not the definition of the main KDE Plasma desktop**.

## Configuration layout

Hyprland configuration is stored under:

    ~/.config/hypr/

The optional Quickshell configuration lives under:

    ~/.config/quickshell/aurora/

The current profile also uses Matugen to generate wallpaper-derived theme values for the shell and supporting applications.

## Installation

From the repository root:

    cd dotfiles
    bash scripts/install.sh

Use this only when you want the optional Hyprland environment.

## Useful keybindings

| Key | Action |
| --- | --- |
| **SUPER + Enter** | Open terminal |
| **SUPER + D** | Open launcher |
| **SUPER + E** | Open file manager |
| **SUPER + Q** | Close window |
| **SUPER + F** | Toggle fullscreen |
| **SUPER + Tab** | Cycle windows |
| **SUPER + 1…0** | Switch workspace |
| **SUPER + Shift + 1…0** | Move window to workspace |
| **SUPER + Shift + R** | Reload Hyprland |
| **Print** | Region screenshot |
| **SUPER + Print** | Full-screen screenshot |

## Wallpaper and colors

The project uses:

    calypso-wallpaper ~/Pictures/wallpapers/my-wallpaper.png

The intended workflow is:

1. choose a wallpaper
2. generate a palette with Matugen
3. refresh the Hyprland/Quickshell visual layer

## Relationship to the main desktop

| Component | Role |
| --- | --- |
| KDE Plasma | Main Calypso desktop |
| Hyprland | Optional, recommended window manager |
| Quickshell | Optional Hyprland shell layer |
| Calamares | Graphical system installer |

The optional Hyprland configuration is not required to use KDE Plasma.