from libqtile.config import Group, Key
from libqtile.lazy import lazy
from keys import mod, keys

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # Switch to group
        Key([mod], i.name,
            lazy.group[i.name].toscreen(),
            desc=f"Switch to group {i.name}"),

        # Move focused window to group and follow
        Key([mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc=f"Move window to group {i.name}"),
    ])
