import os, subprocess, json
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from functions import smart_swap, float_all_windows, tile_all_windows, toggle_floating_all, update_visible_groups, refresh_groups, separator
from colours import current_theme
from qtile_extras.widget import StatusNotifier
from qtile_extras import widget

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
    Key([mod, "shift"], "u", lazy.spawn('/home/array/.config/qtile/scripts/nix.sh'), desc="Nix actions script"),
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
widget_defaults = dict(
    font="Ubuntu Nerd Font Bold",
    fontsize=11,
    padding=3,
    background=current_theme["background"],
    foreground=current_theme["foreground"],
)

widget.extension_defaults = widget_defaults


# --- Bar --- #
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=8),
                widget.GroupBox(
                    fontsize=10,
                    margin_y=3,
                    margin_x=1,
                    padding_y=4,
                    padding_x=6,
                    disable_drag=True,
                    active=current_theme["foreground"],
                    inactive=current_theme["foreground"],
                    rounded=True,
                    highlight_method="block",
                    this_current_screen_border=current_theme["active"],
                    block_highlight_text_color=current_theme["background"],
                    visible_groups=[g.name for g in groups if g.name in [str(i) for i in range(1, 6)]],
                ),
                widget.Spacer(length=4),
                widget.WindowName(
                    format=" ‣ {name}",
                    max_chars=150,
                    background=current_theme["active"],
                    foreground=current_theme["background"]
                ),
                widget.Spacer(length=4),
                widget.GenPollText(
                    update_interval=2,
                    func=lambda: subprocess.check_output(
                        ["/home/array/.config/qtile/scripts/music.sh"],
                        text=True).strip(),
                ),
                widget.ThermalSensor(
                    tag_sensor='Core 0',
                    format='   {temp:.0f}{unit}',
                    threshold=90.0,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('ghostty' + ' -e htop')}
                ),
                widget.TextBox(fmt=" ∷ "),
                widget.Memory(
                    format='  {MemUsed: .0f}{mm}',
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('ghostty' + ' -e htop')}
                ),
                widget.TextBox(fmt=" ∷ "),
                widget.Volume(
                    fmt="   {}",
                    mouse_callbacks = {'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
                    volume_app = "pavucontrol",
                ),
                widget.WidgetBox(
                    fmt=" ∷ ",
                    text_open=" • ",
                    text_close="  ",
                    close_button_location="right",
                    widgets=[
                        widget.StatusNotifier(
                            icon_size=14,
                            padding=4
                        )
                    ]),
                widget.Clock(
                    format="󰥔  %A, %d %b  :  %H:%M"
                ),
                widget.Spacer(length=12),
            ],
            28,
            background=current_theme["background"],
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
