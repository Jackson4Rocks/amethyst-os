# 💚 Calypso Linux

> **Calypso Linux** is an Arch-based Linux distribution centered on **KDE Plasma**, with **Hyprland available as an optional, recommended window manager** for users who want a more keyboard-driven and highly customizable workflow.

<p align="center">
  <strong>Designed to feel intentional.</strong><br>
  KDE Plasma · Hyprland · Calamares · Arch Linux
</p>

---

## 🖥️ Desktop

### KDE Plasma — main desktop

KDE Plasma is the primary Calypso desktop. The live ISO is built around Plasma, SDDM, Calypso branding, wallpapers, and the project's graphical installation flow.

### Hyprland — optional, recommended window manager

Hyprland is included as an optional window manager for users who prefer tiling, keyboard-driven interaction, and deeper customization.

The Hyprland configuration is maintained separately under `dotfiles/`. It is not required for the KDE Plasma experience.

## 📦 Installer

Calypso uses **Calamares** for graphical installation.

The current ISO provides:

- UEFI/systemd-boot installation
- GPT partitioning by default
- ext4 as the default filesystem
- graphical user and hostname setup
- KDE Plasma as the main desktop
- Hyprland as the optional window-manager path
- Calypso branding and wallpapers

## 🧩 Project structure

    Calypso Linux
    ├── Arch Linux base
    ├── KDE Plasma
    ├── Hyprland (optional window manager)
    ├── Calamares installer
    ├── Calypso artwork + wallpapers
    ├── ISO profile
    ├── Optional Hyprland configuration
    └── Website + documentation

## 🎛️ Optional Hyprland configuration

The repository contains an optional Hyprland configuration under `dotfiles/`.

It is intentionally separate from the main KDE Plasma experience and can evolve without changing the core desktop.

See `dotfiles/README.md` for configuration details and keybindings.

## 🔧 Build the ISO

From an Arch Linux build host with `archiso` installed:

    cd ~/calypso-linux
    git pull --ff-only origin main

    sudo rm -rf ~/calypso-build ~/calypso-out
    mkdir -p ~/calypso-build ~/calypso-out

    sudo mkarchiso -v -r \
      -w ~/calypso-build \
      -o ~/calypso-out \
      ./iso

The resulting ISO is written to `~/calypso-out/`.

## 🤝 Contributing

Issues, ideas, improvements, configuration tweaks, artwork, and documentation changes are welcome.

Useful bug reports should include the relevant logs, hardware details, and build context.

## ⚠️ Status

Calypso Linux is an **active personal project** and is still evolving. Expect changes to the installer, desktop configuration, artwork, and release process.

## 👤 Maintainer

**Leon Sony**

This project started as a personal Linux experiment and is being developed openly.

You can also reach the project through the [Telegram group](https://t.me/CalypsoLinux).

---

<p align="center">
  <sub>CALYPSO LINUX · KDE PLASMA · HYPRLAND · CALAMARES · ARCH LINUX</sub>
</p>