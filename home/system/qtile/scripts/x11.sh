xrandr --output DP-1 --mode 1920x1080 --rate 239.76
xrandr --output eDP-1 --mode 1920x1080 --rate 60.00
xclip &
dunst -config /home/array/.cache/wal/dunstrc &
nm-applet &
picom &

wlr-randr --output eDP-1 --off &
wlr-randr --output DP-3 --mode 1920x1080@239.759995 &
wl-copy &
waypaper --restore
dunst -config /home/array/.cache/wal/dunstrc &
