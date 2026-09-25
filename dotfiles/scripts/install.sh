#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$XDG_CONFIG_HOME/hypr"
mkdir -p "$XDG_CONFIG_HOME/kitty"
mkdir -p "$XDG_CONFIG_HOME/fastfetch"
mkdir -p "$XDG_CONFIG_HOME/matugen/templates"
mkdir -p "$XDG_CONFIG_HOME/quickshell/aurora"
mkdir -p "$XDG_CONFIG_HOME/fuzzel"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/calypso"
mkdir -p "$XDG_CONFIG_HOME/quickshell/aurora/assets"

cp "$ROOT/hypr/hyprland.lua" "$XDG_CONFIG_HOME/hypr/hyprland.lua"
cp "$ROOT/hypr/hyprpaper.conf" "$XDG_CONFIG_HOME/hypr/hyprpaper.conf"
cp "$ROOT/kitty/kitty.conf" "$XDG_CONFIG_HOME/kitty/kitty.conf"
cp "$ROOT/kitty/aurora-colors.conf" "$XDG_CONFIG_HOME/kitty/aurora-colors.conf"
cp "$ROOT/fastfetch/config.jsonc" "$XDG_CONFIG_HOME/fastfetch/config.jsonc"
cp "$ROOT/zsh/.zshrc" "$HOME/.zshrc"
cp "$ROOT/../assets/calypso-mark.svg" "$HOME/.local/share/calypso/calypso-mark.svg"
cp "$ROOT/../assets/calypso-mark.svg" "$XDG_CONFIG_HOME/quickshell/aurora/assets/calypso-mark.svg"

cp "$ROOT/quickshell/aurora/shell.qml" "$XDG_CONFIG_HOME/quickshell/aurora/shell.qml"
cp "$ROOT/quickshell/aurora/Theme.qml" "$XDG_CONFIG_HOME/quickshell/aurora/Theme.qml"

cp "$ROOT/matugen/config.toml" "$XDG_CONFIG_HOME/matugen/config.toml"
cp "$ROOT/matugen/templates/aurora-theme.qml" "$XDG_CONFIG_HOME/matugen/templates/aurora-theme.qml"
cp "$ROOT/matugen/templates/kitty-colors.conf" "$XDG_CONFIG_HOME/matugen/templates/kitty-colors.conf"
cp "$ROOT/matugen/templates/fuzzel-colors.ini" "$XDG_CONFIG_HOME/matugen/templates/fuzzel-colors.ini"

cp "$ROOT/fuzzel/fuzzel.ini" "$XDG_CONFIG_HOME/fuzzel/fuzzel.ini"
install -m 0755 "$ROOT/scripts/calypso-wallpaper" "$HOME/.local/bin/calypso-wallpaper"

echo
echo "Aurora Dotfiles installed for Calypso Linux."
echo "Quickshell shell: qs -c aurora"
echo "Wallpaper/theme helper: calypso-wallpaper"
echo "Reload Hyprland with: hyprctl reload"
