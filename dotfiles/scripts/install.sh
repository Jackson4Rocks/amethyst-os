#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$XDG_CONFIG_HOME/hypr"
mkdir -p "$XDG_CONFIG_HOME/kitty"
mkdir -p "$XDG_CONFIG_HOME/fastfetch"
mkdir -p "$XDG_CONFIG_HOME/matugen/templates"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/amethyst"

cp "$ROOT/hypr/hyprland.lua" "$XDG_CONFIG_HOME/hypr/hyprland.lua"
cp "$ROOT/hypr/hyprpaper.conf" "$XDG_CONFIG_HOME/hypr/hyprpaper.conf"
cp "$ROOT/kitty/kitty.conf" "$XDG_CONFIG_HOME/kitty/kitty.conf"
cp "$ROOT/kitty/amethyst-colors.conf" "$XDG_CONFIG_HOME/kitty/amethyst-colors.conf"
cp "$ROOT/fastfetch/config.jsonc" "$XDG_CONFIG_HOME/fastfetch/config.jsonc"
cp "$ROOT/zsh/.zshrc" "$HOME/.zshrc"
cp "$ROOT/matugen/config.toml" "$XDG_CONFIG_HOME/matugen/config.toml"
cp "$ROOT/matugen/templates/amethyst-colors.lua" "$XDG_CONFIG_HOME/matugen/templates/amethyst-colors.lua"
cp "$ROOT/matugen/templates/kitty-colors.conf" "$XDG_CONFIG_HOME/matugen/templates/kitty-colors.conf"

install -m 0755 "$ROOT/scripts/aos-wallpaper" "$HOME/.local/bin/aos-wallpaper"

echo
echo "Amethyst OS AURORA dotfiles installed."
echo "Wallpaper/theme helper: aos-wallpaper"
echo "Reload Hyprland with: hyprctl reload"
