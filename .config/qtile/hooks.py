import os
import subprocess
from libqtile import hook


@hook.subscribe.startup_once
def start_once():
    autostart = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.call([autostart])
