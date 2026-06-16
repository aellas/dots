import os
import subprocess
import libqtile.resources
from libqtile import bar
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.groupbox2 import GroupBoxRule

# ── Colours ────────────────────────────────────────────────────────────────────

colors = {
    "bg":       "#111117",
    "fg":       "#cbd0ec",
    "active":   "#bfc9f4",
    "inactive": "#6c7086",
    "urgent":   "#f38ba8",
    "accent":   "#cba6f7",
}

# ── Widget defaults ─────────────────────────────────────────────────────────────

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=20,
    padding=8,
)
extension_defaults = widget_defaults.copy()

# ── Wi-Fi helper ────────────────────────────────────────────────────────────────

WIFI_ICONS = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]  # 0-20 / 20-40 / 40-60 / 60-80 / 80-100%


def get_wifi():
    try:
        lines = subprocess.check_output(
            ["nmcli", "-t", "-f", "IN-USE,SIGNAL", "dev", "wifi"],
            text=True,
        ).splitlines()
        for line in lines:
            if line.startswith("*"):
                signal = int(line.split(":")[1])
                return WIFI_ICONS[min(signal // 20, 4)]
        return "󰤭 down"
    except Exception:
        return "󰤭"


# ── Bar ─────────────────────────────────────────────────────────────────────────

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=20),

                widget.GroupBox2(
                    highlight_method="line",
                    rounded=False,
                    rules=[
                        GroupBoxRule(line_colour="bfc9f4").when(focused=True),
                        GroupBoxRule(line_colour="111117").when(focused=False),
                    ],
                ),

                widget.Spacer(length=20),
                widget.WindowName(),
                widget.Spacer(),

                widget.Clock(format="%a %d  %H:%M"),

                widget.Spacer(),

                widget.StatusNotifier(
                    icon_size=23,
                    menu_background='111117'),

                widget.TextBox("  "),
                widget.Backlight(
                    fmt="󰃠  {}",
                    backlight_name="intel_backlight",
                ),

                widget.TextBox("  "),
                widget.UPowerWidget(battery_name="BAT0"),
                widget.Battery(format=" {percent:2.0%}"),

                widget.TextBox("  "),
                widget.Volume(fmt="  {}"),

                widget.TextBox("  "),
                widget.GenPollText(
                    update_interval=5,
                    func=get_wifi,
                    fontsize=20,
                ),
                widget.TextBox("  "),
                widget.Bluetooth(default_text="󰂯", fontsize=22),

                widget.TextBox("  "),
            ],
            52,
            background=colors["bg"],
        )
    )
]
