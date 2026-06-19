import subprocess
from libqtile.config import Click, Drag, Key, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()


def smart_swap(qtile):
    layout = qtile.current_layout
    window = qtile.current_window
    if hasattr(layout, "clients") and window in layout.clients:
        index = layout.clients.index(window)
        if index == 0:
            layout.swap_right()
        else:
            layout.swap_main()


@lazy.function
def tile_all_windows(qtile):
    for win in qtile.current_group.windows:
        win.floating = False


keys = [
    # --- Applications ---
    Key(
        [mod],
        "b",
        lazy.spawn("helium-browser-bin --force-device-scale-factor=1.5"),
        desc="Browser",
    ),
    Key([mod], "e", lazy.spawn("emacsclient -c -a emacs"), desc="Emacs"),
    Key(
        [mod],
        "space",
        lazy.spawn(
            "rofi -show drun -modi drun -line-padding 4 -hide-scrollbar -show-icons"
        ),
        desc="App launcher",
    ),
    Key(
        [mod],
        "m",
        lazy.spawn(
            "bash -c 'feishin --ozone-platform=wayland & sleep 0.3 && feishin --ozone-platform=wayland'"
        ),
        desc="Music",
    ),
    Key([mod], "d", lazy.spawn("vesktop"), desc="Discord"),
    Key(
        [mod],
        "n",
        lazy.spawn("wezterm -e joshuto"),
        desc="File manager (TUI)",
    ),
    Key([mod, "shift"], "n", lazy.spawn("dolphin"), desc="File manager (GUI)"),
    Key(
        [mod],
        "Return",
        lazy.spawn("wezterm -e tmux new-session -A -s thinkfor"),
        desc="Terminal",
    ),
    Key(
        [mod, "shift"],
        "p",
        lazy.spawn("sh ~/.config/qtile/scripts/power.sh", shell=True),
        desc="Power",
    ),
    Key(
        [mod],
        "o",
        lazy.spawn("shotman --capture output"),
        desc="File manager (GUI)",
    ),
    Key(
        [mod, "shift"],
        "o",
        lazy.spawn("shotman --capture region"),
        desc="File manager (GUI)",
    ),
    # --- Focus ---
    Key([mod], "h", lazy.layout.left(), desc="Focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Focus right"),
    Key([mod], "j", lazy.layout.down(), desc="Focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Focus up"),
    # --- Move windows ---
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # --- Resize windows ---
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow up"),
    # --- Layout ---
    Key([mod], "Tab", lazy.function(smart_swap), desc="Smart swap with master"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "t", tile_all_windows(), desc="Tile all windows"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle split/unsplit",
    ),
    # --- Qtile ---
    Key([mod], "q", lazy.window.kill(), desc="Kill window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Quit Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Run command"),
]

# VT switching (Wayland only)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )
