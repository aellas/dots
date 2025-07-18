import os, subprocess, json, socket
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from functions import smart_swap, float_all_windows, tile_all_windows, toggle_floating_all, update_visible_groups, refresh_groups, separator
from colours import current_theme
from qtile_extras.widget import StatusNotifier
from qtile_extras import widget

hostname = socket.gethostname()

IS_LAPTOP = hostname in ["xpsnix", "thinknix"]
BAR_FONT_SIZE = 13 if IS_LAPTOP else 11
BAR_SIZE = 36 if IS_LAPTOP else 28
GROUP_BOX = 12 if IS_LAPTOP else 10

# --- Mod --- #
mod = "mod4"

# --- Key Bindings --- #
keys = [
# --- My Personal Keybinds --- #
    Key([mod], "Return", lazy.spawn('ghostty'), desc="Launch terminal"),
    Key([mod], "Space", lazy.spawn('rofi -show drun'), desc="Launch app launcher (rofi)"),
    Key([mod], "b", lazy.spawn('firefox'), desc="Launch web browser"),
    Key([mod], "n", lazy.spawn('ghostty -e yazi'), desc="Launch Yazi"),
    Key([mod], "h", lazy.spawn('thunar'), desc="Launch Thunar"),
    Key([mod], "j", lazy.spawn('dbus-run-session env _JAVA_AWT_WM_NONREPARENTING=1 bolt-launcher'), desc="Launch bolt launcher"),
    Key([mod], "m", lazy.spawn('youtube-music'), desc="Launch YouTube Music"),
    Key([mod], "s", lazy.spawn('steam'), desc="Launch steam"),
    Key([mod], "d", lazy.spawn('discord'), desc="Launch Discord"),
    Key([mod], "Backslash", lazy.spawn('codium'), desc="Launch vscodium"),
    Key([mod], "f11", lazy.spawn('gpick --pick'), desc="Launch color picker"),
    Key([mod], "l", lazy.spawn('ghostty -e nvim'), desc="Launch nvim"),
    Key([mod], "k", lazy.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command 'echo {cmd} | xclip -selection clipboard'"), desc="Launch clipboard manager"),    
    Key([], "Home", lazy.spawn('flameshot full --clipboard --path /home/array/Pictures/Screenshots'), desc="Take full screenshot"),
    Key([mod], "Home", lazy.spawn('flameshot gui --clipboard --path /home/array/Pictures/Screenshots --accept-on-select'), desc="Take region screenshot"),
# --- Qtile Specific Keybinds --- #
    Key([mod], "o", lazy.hide_show_bar(), desc="Hides the bar"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Logout / Quit Qtile"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "Tab", lazy.function(smart_swap), desc="Smart swap with master"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Left", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod], "Right", lazy.layout.grow(), desc="Grow window"),
    Key([mod], "r", lazy.layout.reset(), desc="Reset layout"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "period", lazy.next_layout(), desc="Switch to next layout"),
    Key([mod], "comma", lazy.prev_layout(), desc="Switch to previous layout"),
    Key([mod, "shift"], "Space", toggle_floating_all(), desc="Toggle float/tile for all windows"), 
    Key([mod], "f", float_all_windows(), desc="Set all windows to floating"),
    Key([mod], "t", tile_all_windows(), desc="Set all windows to tiled"),

# --- Volume / Brightness Keybinds --- #
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%"), desc="Increase volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%"), desc="Decrease volume"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle mute"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 150+%"), desc="Increase brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5-%"), desc="Decrease brightness"),
]

# --- Mouse Bindings ---
mouse = [
	Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], 'Button2', lazy.window.bring_to_front())
	]
# --- Groups ---
group_labels = {str(i + 1): str(i + 1) for i in range(9)}
groups = [Group(name, label=label) for name, label in group_labels.items()]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False), desc=f"Move focused window to group {i.name}"),
    ])

# --- Scratchpad ---
groups.append(ScratchPad("scratchpad", [
    DropDown("term", f"ghostty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("music", f"ghostty -e rmpc", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("files", f"ghostty -e yazi", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("theme", f"bash /home/array/.config/qtile/scripts/switch_theme.sh", width=1.0, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("nix", f"ghostty -e /home/array/.config/qtile/scripts/nix.sh", width=1.0, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("sound", f"pavucontrol", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
    DropDown("vpn", f"protonvpn-app", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1.0, on_focus_lost='hide'),
]))

# --- Scratchpad Keybinds ---
keys.extend([
    Key([mod, "shift"], "Return", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod, "shift"], "m", lazy.group["scratchpad"].dropdown_toggle("music")),
    Key([mod, "shift"], "t", lazy.group["scratchpad"].dropdown_toggle("theme")),
    Key([mod, "shift"], "n", lazy.group["scratchpad"].dropdown_toggle("files")),
    Key([mod, "shift"], "s", lazy.group["scratchpad"].dropdown_toggle("sound")),
    Key([mod, "shift"], "p", lazy.group["scratchpad"].dropdown_toggle("vpn")),
    Key([mod, "shift"], "u", lazy.group["scratchpad"].dropdown_toggle("nix")),
    Key([mod], "x", lazy.group["scratchpad"].hide_all()),
])

# --- Borders for layouts ---
layout_conf = { 
    'border_focus': current_theme.get("active"),
    'border_normal': current_theme.get("inactive"),
    'border_width': 2,
    'margin': 8
}

# --- Layouts ---
layouts = [
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.MonadThreeCol(**layout_conf),
    layout.Bsp(**layout_conf),
    layout.RatioTile(**layout_conf),
    layout.Spiral(**layout_conf),
]

# --- Bar --- #
battery_widget = (
    widget.Battery(
        format=" ∷   {char}  {percent:2.0%}",
        low_percentage=0.2,
        show_short_text=False,
        notify_below=10,
        update_interval=30,
        charge_char="󰂄",
        discharge_char="󰂀",
        empty_char="󰂎",
        full_char="󰁹",
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("xfce4-power-manager-settings")}
    )
    if IS_LAPTOP else widget.Spacer(length=0)
)

widget_defaults = dict(
    font="Ubuntu Nerd Font Bold",
    fontsize=BAR_FONT_SIZE,
    padding=3,
    background='#D9D9D9',
    foreground='#363636',
)
widget.extension_defaults = widget_defaults

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=4),
                widget.GroupBox(
                    fontsize=GROUP_BOX,
                    margin_y=3,
                    margin_x=1,
                    padding_y=4,
                    padding_x=6,
                    disable_drag=True,
                    active='#363636',
                    inactive='#363636',
                    rounded=True,
                    highlight_method="block",
                    this_current_screen_border='#333333',
                    block_highlight_text_color='#D9D9D9',
                    visible_groups=[g.name for g in groups if g.name in [str(i) for i in range(1, 6)]],
                ),
                widget.Spacer(length=4),
                widget.WindowName(
                    format=" ‣ {name}",
                    max_chars=150,
                ),
                widget.Spacer(),
                widget.Spacer(length=4),
                widget.ThermalSensor(
                    tag_sensor='Core 0',
                    format='   {temp:.0f}{unit}',
                    threshold=90.0,
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('ghostty -e htop')}
                ),
                widget.TextBox(fmt=" ∷ "),
                widget.Memory(
                    format='  {MemUsed: .0f}{mm}',
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('ghostty -e htop')}
                ),
                battery_widget,
                widget.TextBox(fmt=" ∷ "),
                widget.Volume(
                    fmt="   {}",
                    mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
                    volume_app="pavucontrol",
                ),
                widget.WidgetBox(
                    fmt=" ∷ ",
                    text_open=" • ",
                    text_close="  ",
                    close_button_location="right",
                    widgets=[
                        StatusNotifier(
                            icon_size=14,
                            padding=4
                        )
                    ],
                ),
                widget.Clock(
                    format="󰥔  %A, %d %b  :  %H:%M"
                ),
                widget.Spacer(length=12),
            ],
            BAR_SIZE,
            background='#00000000',
            opacity=1.0,
            margin=[6, 8, -2, 8]
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
    border_focus=current_theme.get("active"), 
    border_normal=current_theme.get("active"),
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

# --- Autostart ---
@hook.subscribe.startup_once
def autostart():
    backend_name = qtile.core.name
    if backend_name == "wayland":
        autostart_script = os.path.expanduser('~/.config/qtile/scripts/wayland.sh')
    elif backend_name == "x11":
        autostart_script = os.path.expanduser('~/.config/qtile/scripts/x11.sh')
    if os.path.exists(autostart_script):
        subprocess.Popen(['bash', autostart_script])

auto_fullscreen = True
focus_on_window_activation = "never"
reconfigure_screens = True
auto_minimize = True
wmname = "qtile"
