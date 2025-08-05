import os
import subprocess
import json
import socket

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland.inputs import InputConfig
from qtile_extras import widget
from qtile_extras.widget import StatusNotifier

from functions import (
    smart_swap,
    float_all_windows,
    tile_all_windows,
    toggle_floating_all,
    update_visible_groups,
    refresh_groups,
    separator,
)

# --- Hostname / Machine Specific Settings --- #
hostname = socket.gethostname()
IS_LAPTOP = hostname in ["xpsnix", "thinknix"]
BAR_FONT_SIZE = 11 if IS_LAPTOP else 11
BAR_SIZE = 28 if IS_LAPTOP else 28

# --- Mod Key --- #
mod = "mod4"

# --- Key Bindings --- #
keys = [
    # --- Personal Keybinds --- #
    Key([mod], "Return", lazy.spawn("ghostty"), desc="Launch terminal"),
    Key([mod], "Space", lazy.spawn("rofi -show drun"), desc="Launch app launcher (rofi)"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch web browser"),
    Key([mod], "n", lazy.spawn("ghostty -e yazi"), desc="Launch Yazi"),
    Key([mod], "h", lazy.spawn("nemo"), desc="Launch Thunar"),
    Key([mod], "j", lazy.spawn("dbus-run-session env _JAVA_AWT_WM_NONREPARENTING=1 bolt-launcher"), desc="Launch bolt launcher"),
    Key([mod], "m", lazy.spawn("youtube-music"), desc="Launch YouTube Music"),
    Key([mod], "s", lazy.spawn("steam"), desc="Launch Steam"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch Discord"),
    Key([mod], "Backslash", lazy.spawn("codium"), desc="Launch VSCodium"),
    Key([mod], "c", lazy.spawn("wl-color-picker clipboard"), desc="Launch color picker"),
    Key([mod], "l", lazy.spawn("ghostty -e nvim"), desc="Launch Neovim"),
    Key([mod], "k", lazy.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command 'echo {cmd} | xclip -selection clipboard'"), desc="Launch clipboard manager"),
    Key([], "Home", lazy.spawn("/home/array/Documents/GitHub/dots/home/system/qtile/scripts/screenshot.sh"), desc="Take full screenshot"),
    Key([mod], "Home", lazy.spawn("bash ~/.config/qtile/scripts/screenshot_region.sh"), desc="Take region screenshot"),

    # --- Qtile Specific --- #
    Key([mod], "o", lazy.hide_show_bar(), desc="Hide the bar"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Quit Qtile"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload config"),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "Tab", lazy.function(smart_swap), desc="Smart swap with master"),
    Key([mod], "Down", lazy.layout.down(), desc="Focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Focus up"),
    Key([mod], "Left", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod], "Right", lazy.layout.grow(), desc="Grow window"),
    Key([mod], "r", lazy.layout.reset(), desc="Reset layout"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "period", lazy.next_layout(), desc="Next layout"),
    Key([mod], "comma", lazy.prev_layout(), desc="Previous layout"),
    Key([mod, "shift"], "Space", toggle_floating_all(), desc="Toggle float/tile all"),
    Key([mod], "f", float_all_windows(), desc="Float all windows"),
    Key([mod], "t", tile_all_windows(), desc="Tile all windows"),

    # --- Volume / Brightness --- #
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%"), desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle mute"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 150+%"), desc="Brightness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5-%"), desc="Brightness down"),
]

# --- Mouse Bindings --- #
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# --- Groups --- #
icons = ["󱓻"] * 9
group_labels = {str(i + 1): icons[i] for i in range(9)}
groups = [Group(name, label=label) for name, label in group_labels.items()]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False), desc=f"Move window to group {i.name}"),
    ])

# --- ScratchPad --- #
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "ghostty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
    DropDown("music", "ghostty -e rmpc", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
    DropDown("files", "ghostty -e yazi", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
    DropDown("sound", "wiremix", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
    DropDown("vpn", "protonvpn-app", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
    DropDown("nix", "ghostty -e ~/.config/qtile/scripts/nix.sh", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost="hide"),
]))

# --- ScratchPad Keybinds --- #
keys.extend([
    Key([mod, "shift"], "Return", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod, "shift"], "m", lazy.group["scratchpad"].dropdown_toggle("music")),
    Key([mod, "shift"], "n", lazy.group["scratchpad"].dropdown_toggle("files")),
    Key([mod, "shift"], "s", lazy.group["scratchpad"].dropdown_toggle("sound")),
    Key([mod, "shift"], "p", lazy.group["scratchpad"].dropdown_toggle("vpn")),
    Key([mod, "shift"], "u", lazy.group["scratchpad"].dropdown_toggle("nix")),
    Key([mod], "x", lazy.group["scratchpad"].hide_all()),
])

# --- Layouts --- #
layout_conf = {
    "border_focus": "#91ACD1",
    "border_normal": "#6B7089",
    "border_width": 2,
    "margin": 4,
}

layouts = [
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.MonadThreeCol(**layout_conf),
    layout.Bsp(**layout_conf),
    layout.RatioTile(**layout_conf),
    layout.Spiral(**layout_conf),
]

floating_layout = layout.Floating(
    border_width=2,
    border_focus="#91ACD1",
    border_normal="#91ACD1",
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="feh"),
        Match(wm_class="net-runelite-client-RuneLite"),
    ],
)

# --- Wayland Input Configs --- #
wl_input_rules = {
    "type:touchpad": InputConfig(
        tap=True,
        natural_scroll=False,
        dwt=True,
        accel_profile="adaptive",
        pointer_accel=0,
    ),
}

# --- Widgets & Bar --- #
widget_defaults = dict(
    font="Ubuntu Nerd Font Bold",
    fontsize=12,
    padding=2,
    background="#161821",
    foreground="#D2D4DE",
)
widget.extension_defaults = widget_defaults

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=6),
                widget.GroupBox(
                    fontsize=8,
                    margin_y=3,
                    margin_x=1,
                    padding_y=1,
                    padding_x=4,
                    disable_drag=True,
                    active="#D2D4DE",
                    inactive="#D2D4DE",
                    rounded=True,
                    highlight_method="block",
                    this_current_screen_border="#91ACD1",
                    block_highlight_text_color="#91ACD1",
                    visible_groups=[g.name for g in groups if g.name in [str(i) for i in range(1, 6)]],
                ),
                widget.Spacer(length=4),
                widget.WindowName(format=" ‣  {name}", max_chars=150, fontsize=11),
                widget.Spacer(),
                widget.Clock(format="%A, %d %b      %H:%M ", fontsize=11),
                widget.Spacer(),
                widget.Mpris2(format="󰝚   {xesam:artist}  -  {xesam:title}", fontsize=11, mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("youtube-music")}),
                separator(),
                widget.WidgetBox(
                    fmt="  ",
                    close_button_location="right",
                    widgets=[
                        StatusNotifier(icon_size=12, padding=4),
                        separator(),
                        widget.CPU(format="    {load_percent}%", fontsize=11),
                        widget.Memory(format="   {MemUsed: .0f}{mm}", fontsize=11),
                    ],
                ),
                separator(),
                widget.CurrentLayout(fontsize=11),
                separator(),
                widget.TextBox(fmt="  ", mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("ghostty -e nmtui")}),
                separator(),
                widget.Battery(
                    format="  {char}  ",
                    low_percentage=0.2,
                    show_short_text=False,
                    notify_below=10,
                    update_interval=30,
                    charge_char="",
                    discharge_char="",
                    empty_char="",
                    full_char="",
                    not_charging_char="󰢝",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("xfce4-power-manager-settings")},
                ),
                separator(),
                widget.Volume(
                    fmt=" ",
                    mouse_callbacks={"Button3": lambda: qtile.cmd_spawn("ghostty -e wiremix")},
                ),
                separator(),
                widget.TextBox(fmt="  ", foreground="#D2D4DE", fontsize=13),
                widget.Spacer(length=14),
            ],
            30,
            background="#161821",
            opacity=1.0,
            margin=[6, 6, 2, 6],
        ),
    ),
]

# --- Other Settings ---
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True
floating_layout = layout.Floating(
    border_width=2,
    border_focus="#91ACD1", 
    border_normal="#D2D4DE",
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="feh"),
        Match(wm_class="net-runelite-client-RuneLite")
    ]
)

@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.expanduser('~/.config/qtile/scripts/wayland.sh')
    subprocess.Popen(['bash', autostart_script])

auto_fullscreen = True
focus_on_window_activation = "never"
reconfigure_screens = True
auto_minimize = True
wmname = "qtile"
