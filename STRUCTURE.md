# █▀▄ █▀█ ▀█▀ █▀▀ █ █░░ █▀▀ █▀
# █▄▀ █▄█ ░█░ █▀░ █ █▄▄ ██▄ ▄█
# ------------------------------------------------------
# Full Tree Annotation of the Dotfiles folder.

~/dotfiles/
├── config.env              ← Centralized source of truth for all system variables
├── install.sh              ← Main idempotent setup script (Pacman/AUR + Symlinks)
├── README.md               ← Documentation for quickstart and troubleshooting
├── STRUCTURE.md            ← This file (annotated tree map)
│
├── hypr/                   ← Modular Hyprland configuration
│   ├── hyprland.conf       ← Main entry point, sources all modules
│   ├── keybinds.conf       ← Global keyboard shortcuts and app launches
│   ├── windowrules.conf    ← Specific window behaviors (floating, opacity)
│   ├── monitors.conf       ← Dynamic monitor resolutions and positions
│   ├── env.conf            ← Environment variables (XDG, QT, GDK)
│   └── animations.conf     ← Visual transitions and motion settings
│
├── waybar/                 ← Status bar configuration
│   ├── config.jsonc        ← Bar layout and module definitions
│   └── style.css           ← Visual styling for the bar (themed)
│
├── rofi/                   ← Application launcher
│   └── config.rasi         ← Launcher UI and theme (Catppuccin)
│
├── dunst/                  ← Notification system
│   └── dunstrc             # Notification layout and color scheme
│
├── kitty/                  ← Terminal emulator
│   └── kitty.conf          # Terminal appearance and fonts
│
└── filemanager/            ← KDE/Dolphin settings
    └── Kvantum.kvconfig    # Qt/Kvantum theming engine settings
