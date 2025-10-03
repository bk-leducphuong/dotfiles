#!/usr/bin/env bash
PROFILE_NAME="LogView"
PROFILE_ID=$(uuidgen)

# Register new profile
dconf write /org/gnome/terminal/legacy/profiles:/list \
    "$(dconf read /org/gnome/terminal/legacy/profiles:/list | sed "s/]$/, '$PROFILE_ID']/")"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/visible-name "'$PROFILE_NAME'"

# Colors
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/background-color "'#1e1e1e'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/foreground-color "'#d4d4d4'"
dconf write /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/palette \
"['#808080', '#ff5555', '#6a9955', '#ffcc00', '#4ec9b0', '#c586c0', '#00acc1', '#d4d4d4',
  '#808080', '#ff5555', '#6a9955', '#ffcc00', '#4ec9b0', '#c586c0', '#00acc1', '#d4d4d4']"

echo "✅ New GNOME Terminal profile '$PROFILE_NAME' created. Select it in terminal preferences."

