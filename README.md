# █▀▄ █▀█ ▀█▀ █▀▀ █ █░░ █▀▀ █▀
# █▄▀ █▄█ ░█░ █▀░ █ █▄▄ ██▄ ▄█
# ------------------------------------------------------
# Portable Arch Linux Rice based on HyDE logic.

## 🚀 Quick Start
1. **Clone the repo:** `git clone <your-repo> ~/dotfiles`
2. **Configure:** Edit `~/dotfiles/config.env` with your monitor names and preferences.
3. **Install:** Run `./install.sh`

## 🛠️ Configuration
All settings are centralized in `config.env`.

| Variable | Description |
|----------|-------------|
| `MONITOR_NAME` | Your primary monitor (e.g., `DP-1`, `eDP-1`) |
| `MONITOR_RES`  | Resolution (e.g., `1920x1080@144`) |
| `TERMINAL`     | Preferred terminal emulator |
| `THEME`        | Active theme name |

## 📂 Structure
- `hypr/`: Modular Hyprland settings.
- `waybar/`: Top bar configuration.
- `rofi/`: App launcher themes.
- `dunst/`: Notification settings.
- `install.sh`: The master deployment script.

## ⚠️ Troubleshooting
- **Monitor not found:** Run `hyprctl monitors` and update `config.env`.
- **Icons/Fonts missing:** Ensure the packages listed in `install.sh` are installed.
# dotfiles
