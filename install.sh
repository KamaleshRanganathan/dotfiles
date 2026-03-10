#!/usr/bin/env bash

# █ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░
# █ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄
# ------------------------------------------------------
# Idempotent install script for Arch Linux Rice.
# Usage: ./install.sh [--dry-run]

set -e

# ── Load Config ──────────────────────────────────────
SCR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ ! -f "$SCR_DIR/config.env" ]; then
    echo "Error: config.env not found!"
    exit 1
fi
source "$SCR_DIR/config.env"

# ── Arguments ────────────────────────────────────────
DRY_RUN=0
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=1
    echo -e "\033[0;33m[DRY RUN MODE] - No changes will be made to the system.\033[0m"
fi

# ── Colors ───────────────────────────────────────────
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'

# ── Dependencies ─────────────────────────────────────
PACMAN_PKGS=(
    hyprland waybar rofi dunst kitty swww hyprlock hypridle
    grim slurp satty cliphist wl-clip-persist
    nwg-look qt5ct qt6ct kvantum imagemagick
    pavucontrol pamixer brightnessctl network-manager-applet
    firefox dolphin starship fastfetch jq parallel
)

AUR_PKGS=(
    wlogout
)

# ── Installation Logic ───────────────────────────────
if [ $DRY_RUN -eq 0 ]; then
    echo -e "${BLUE}Checking Pacman packages...${NC}"
    sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

    # Check for AUR helper
    AUR_HELPER=""
    if command -v paru &> /dev/null; then AUR_HELPER="paru";
    elif command -v yay &> /dev/null; then AUR_HELPER="yay"; fi

    if [ -n "$AUR_HELPER" ]; then
        echo -e "${BLUE}Installing AUR packages via $AUR_HELPER...${NC}"
        $AUR_HELPER -S --needed --noconfirm "${AUR_PKGS[@]}"
    else
        echo -e "${YELLOW}Warning: No AUR helper (yay/paru) found. Skipping AUR packages.${NC}"
    fi
else
    echo -e "${YELLOW}Would install Pacman packages: ${PACMAN_PKGS[*]}${NC}"
    echo -e "${YELLOW}Would install AUR packages: ${AUR_PKGS[*]}${NC}"
fi

# ── Configuration Deployment ──────────────────────────
deploy_config() {
    local src_folder="$1"
    local dest_folder="$HOME/.config/$2"
    
    echo -e "${BLUE}Deploying $2...${NC}"
    
    if [ $DRY_RUN -eq 1 ]; then
        echo -e "${YELLOW}Would create directory $dest_folder and copy files from $src_folder${NC}"
        return
    fi

    mkdir -p "$dest_folder"
    
    # Copy all files and subdirectories recursively
    cp -r "$src_folder/"* "$dest_folder/"
    
    # Replace variables from config.env in all text files
    find "$dest_folder" -type f -exec grep -Iq . {} \; -print | while read -r target; do
        sed -i "s/\$MONITOR_NAME/$MONITOR_NAME/g" "$target" 2>/dev/null || true
        sed -i "s/\$MONITOR_RES/$MONITOR_RES/g" "$target" 2>/dev/null || true
        sed -i "s/\$MONITOR_POS/$MONITOR_POS/g" "$target" 2>/dev/null || true
        sed -i "s/\$MONITOR_SCALE/$MONITOR_SCALE/g" "$target" 2>/dev/null || true
        sed -i "s/\$CURSOR_THEME/$CURSOR_THEME/g" "$target" 2>/dev/null || true
        sed -i "s/\$CURSOR_SIZE/$CURSOR_SIZE/g" "$target" 2>/dev/null || true
        sed -i "s/\$FONT_MAIN/$FONT_MAIN/g" "$target" 2>/dev/null || true
        sed -i "s/\$FONT_MONO/$FONT_MONO/g" "$target" 2>/dev/null || true
        sed -i "s/\$TERMINAL/$TERMINAL/g" "$target" 2>/dev/null || true
        sed -i "s/\$BROWSER/$BROWSER/g" "$target" 2>/dev/null || true
        sed -i "s/\$EDITOR/$EDITOR/g" "$target" 2>/dev/null || true
        sed -i "s/\$FILEMANAGER/$FILEMANAGER/g" "$target" 2>/dev/null || true
    done
}

deploy_config "$SCR_DIR/hypr" "hypr"
deploy_config "$SCR_DIR/waybar" "waybar"
deploy_config "$SCR_DIR/rofi" "rofi"
deploy_config "$SCR_DIR/dunst" "dunst"
deploy_config "$SCR_DIR/kitty" "kitty"
deploy_config "$SCR_DIR/scripts" "scripts"
deploy_config "$SCR_DIR/shell" "shell"

# ── Permissions ───────────────────────────────────────
if [ $DRY_RUN -eq 0 ]; then
    chmod +x ~/.config/scripts/*.sh || true
fi

# ── Assets Migration (Wallpapers) ────────────────────
if [ $DRY_RUN -eq 0 ]; then
    echo -e "${BLUE}Setting up wallpapers...${NC}"
    mkdir -p ~/Pictures/wallpapers
    # If HyDE wallpapers exist, symlink them
    if [ -d "$HOME/.local/share/hyde/wallpapers" ]; then
        echo -e "${GREEN}Linking HyDE wallpapers...${NC}"
        ln -snf "$HOME/.local/share/hyde/wallpapers/"* ~/Pictures/wallpapers/
    fi
fi

# ── Special App Flags ─────────────────────────────────
if [ $DRY_RUN -eq 0 ]; then
    echo -e "${BLUE}Setting up application flags (Wayland support)...${NC}"
    mkdir -p ~/.config
    echo "--enable-features=UseOzonePlatform --ozone-platform=wayland" > ~/.config/electron-flags.conf
    echo "--enable-features=UseOzonePlatform --ozone-platform=wayland" > ~/.config/spotify-flags.conf
    echo "--enable-features=UseOzonePlatform --ozone-platform=wayland" > ~/.config/code-flags.conf
fi

echo -e "${GREEN}Installation Complete!${NC}"
if [ $DRY_RUN -eq 0 ]; then
    echo -e "Please log out and log back in, or run 'hyprctl reload' to apply changes."
fi
