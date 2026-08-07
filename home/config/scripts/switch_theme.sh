#!/usr/bin/env sh

THEMES_DIR="$HOME/nux/home/config/themes"
STATE_FILE="$THEMES_DIR/.current"
ACTIVE_POLYBAR="$HOME/.config/polybar/colors.ini"

THEMES=$(find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort)
CURRENT=$(cat "$STATE_FILE" 2>/dev/null)

NEW=$(echo "$THEMES" | rofi -dmenu -p "Theme ($CURRENT)")
[ -z "$NEW" ] && exit 0

echo "$NEW" >"$STATE_FILE"

# ── Polybar ──
cp "$THEMES_DIR/$NEW/colours.ini" "$ACTIVE_POLYBAR"
polybar-msg cmd quit 2>/dev/null
while pgrep -x polybar >/dev/null; do sleep 0.1; done
polybar main &

# ── ST terminal ──
# Always merge on top of base ~/.Xresources
xrdb ~/.Xresources
if [ -f "$THEMES_DIR/$NEW/st.Xresources" ]; then
	xrdb -merge "$THEMES_DIR/$NEW/st.Xresources"
fi
pidof st | xargs -r kill -s USR1

# ── Wezterm ──
echo "$NEW" >~/nux/home/config/themes/.current
touch ~/.config/wezterm/wezterm.lua 2>/dev/null
pidof wezterm | xargs -r kill -USR1 2>/dev/null
