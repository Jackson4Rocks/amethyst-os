#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$XDG_CONFIG_HOME/hypr"
mkdir -p "$XDG_CONFIG_HOME/kitty"
mkdir -p "$XDG_CONFIG_HOME/fastfetch"
mkdir -p "$XDG_CONFIG_HOME/matugen/templates"
mkdir -p "$XDG_CONFIG_HOME/quickshell/amethyst"
mkdir -p "$XDG_CONFIG_HOME/fuzzel"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/amethyst"
mkdir -p "$XDG_CONFIG_HOME/quickshell/amethyst/assets"

cp "$ROOT/hypr/hyprland.lua" "$XDG_CONFIG_HOME/hypr/hyprland.lua"
cp "$ROOT/hypr/hyprpaper.conf" "$XDG_CONFIG_HOME/hypr/hyprpaper.conf"
cp "$ROOT/kitty/kitty.conf" "$XDG_CONFIG_HOME/kitty/kitty.conf"
cp "$ROOT/kitty/amethyst-colors.conf" "$XDG_CONFIG_HOME/kitty/amethyst-colors.conf"
cp "$ROOT/fastfetch/config.jsonc" "$XDG_CONFIG_HOME/fastfetch/config.jsonc"
cp "$ROOT/zsh/.zshrc" "$HOME/.zshrc"
cp "$ROOT/assets/amethyst-mark.svg" "$HOME/.local/share/amethyst/amethyst-mark.svg"
cp "$ROOT/assets/amethyst-mark.svg" "$XDG_CONFIG_HOME/quickshell/amethyst/assets/amethyst-mark.svg"

cp "$ROOT/quickshell/amethyst/shell.qml" "$XDG_CONFIG_HOME/quickshell/amethyst/shell.qml"
cp "$ROOT/quickshell/amethyst/Theme.qml" "$XDG_CONFIG_HOME/quickshell/amethyst/Theme.qml"

cp "$ROOT/matugen/config.toml" "$XDG_CONFIG_HOME/matugen/config.toml"
cp "$ROOT/matugen/templates/amethyst-theme.qml" "$XDG_CONFIG_HOME/matugen/templates/amethyst-theme.qml"
cp "$ROOT/matugen/templates/kitty-colors.conf" "$XDG_CONFIG_HOME/matugen/templates/kitty-colors.conf"
cp "$ROOT/matugen/templates/fuzzel-colors.ini" "$XDG_CONFIG_HOME/matugen/templates/fuzzel-colors.ini"

cp "$ROOT/fuzzel/fuzzel.ini" "$XDG_CONFIG_HOME/fuzzel/fuzzel.ini"
install -m 0755 "$ROOT/scripts/aos-wallpaper" "$HOME/.local/bin/aos-wallpaper"

echo
echo "Amethyst OS AURORA dotfiles installed."
echo "Quickshell shell: qs -c amethyst"
echo "Wallpaper/theme helper: aos-wallpaper"
echo "Reload Hyprland with: hyprctl reload"
