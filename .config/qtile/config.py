from keys import keys, mod
from groups import groups
from layouts import layouts, floating_layout
from screens import screens, widget_defaults, extension_defaults
from rules import mouse, dgroups_key_binder, dgroups_app_rules
from hooks import *
from libqtile.backend.wayland import InputConfig
# Behaviour
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
auto_fullscreen = True
auto_minimize = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True

generate_screens = None
idle_timers = []
idle_inhibitors = []
wmname = "qtile"
# Wayland input config
wl_input_rules = {
    "type:keyboard": InputConfig(
        kb_layout="gb",
    ),
    "type:touchpad": InputConfig(
        natural_scroll=True,
        tap=True,
        tap_button_map="lrm",  # 1-finger=left, 2-finger=right, 3-finger=middle
        drag=True,
        dwt=True,              # disable while typing
        accel_profile="adaptive",
    ),
}

wl_xcursor_theme = "Bibata-Modern-Ice"
wl_xcursor_size = 36
