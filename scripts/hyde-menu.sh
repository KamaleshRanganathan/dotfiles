#!/usr/bin/env bash

# █▀▄ █▀█ █▀█ █▀█ █▀▄ █▀█ █░█ █▄░█   █▀▄▀█ █▀▀ █▄░█ █░█
# █▄▀ █▄█ █▀▀ █▀▀ █▄▀ █▄█ ▀▄▀ █░▀█   █░▀░█ ██▄ █░▀█ █▄█

# Simplified HyDE-style menu using Rofi

# ── Options ───────────────────────────────────────────
options="󰸉 Select Wallpaper\n󰃟 Select Theme\n󱎔 Select Animations\n󰕮 Select Waybar Layout\n󰐥 Power Menu"

# ── Launcher ──────────────────────────────────────────
chosen="$(echo -e "$options" | rofi -dmenu -i -p "HyDE Menu" -config ~/.config/rofi/config.rasi)"

case $chosen in
    *"Wallpaper"*)
        swww img $(find ~/Pictures/wallpapers -type f | rofi -dmenu -p "Select Wallpaper")
        ;;
    *"Theme"*)
        # Placeholder for theme switcher logic
        notify-send "Theme Switcher" "Coming soon! Edit config.env to change themes."
        ;;
    *"Animations"*)
        notify-send "Animations" "Edit ~/.config/hypr/animations.conf to change."
        ;;
    *"Waybar"*)
        notify-send "Waybar" "Restarting Waybar..."
        killall waybar && waybar &
        ;;
    *"Power"*)
        wlogout
        ;;
esac
