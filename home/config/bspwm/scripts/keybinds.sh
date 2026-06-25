#!/usr/bin/env sh

SXHKDRC="${SXHKDRC:-$HOME/.config/sxhkd/sxhkdrc}"

if [[ ! -f "$SXHKDRC" ]]; then
    notify-send "keybinds.sh" "sxhkdrc not found at $SXHKDRC"
    exit 1
fi

parse_keybinds() {
    local comment=""
    local key=""
    local in_block=0

    while IFS= read -r line; do
        # Skip empty lines, reset block
        if [[ -z "$line" ]]; then
            comment=""
            key=""
            in_block=0
            continue
        fi

        # Comment line — capture as description
        if [[ "$line" =~ ^#[[:space:]]*(.*) ]]; then
            desc="${BASH_REMATCH[1]}"
            # Skip section header comments (all caps or dashes)
            if [[ "$desc" =~ ^[-[:space:]]+$ ]] || [[ "$desc" =~ ^[[:upper:][:space:]_()-]+$ ]]; then
                comment=""
            else
                comment="$desc"
            fi
            in_block=0
            continue
        fi

        # Key binding line (doesn't start with whitespace, not a comment)
        if [[ "$line" =~ ^[^[:space:]] ]] && [[ ! "$line" =~ ^# ]]; then
            key="$line"
            in_block=1
            continue
        fi

        # Command line (starts with whitespace) — emit entry
        if [[ $in_block -eq 1 ]] && [[ "$line" =~ ^[[:space:]] ]]; then
            cmd=$(echo "$line" | sed 's/^[[:space:]]*//')
            # Format the key nicely
            pretty_key=$(echo "$key" \
                | sed 's/super/⊞ Super/g' \
                | sed 's/alt/Alt/g' \
                | sed 's/ctrl/Ctrl/g' \
                | sed 's/shift/Shift/g' \
                | sed 's/ + / + /g')

            if [[ -n "$comment" ]]; then
                label="$comment"
            else
                # Derive label from command
                label=$(echo "$cmd" | sed 's|.*/||; s/ .*//; s/^bspc /bspc /; s/^wezterm/terminal/; s/^rofi/launcher/')
            fi

            printf "%-28s  %-32s  %s\n" "$pretty_key" "$cmd"
            in_block=0
            comment=""
            continue
        fi
    done < "$SXHKDRC"
}

# Build the list and pipe to rofi
CHOICE=$(parse_keybinds | rofi \
    -dmenu \
    -i \
    -p "Keybinds" \
    -theme-str 'window {width: 70%;}' \
    -theme-str 'listview {lines: 20;}' \
    -theme-str 'element-text {font: "monospace 18";}' \
    -mesg "Search keybindings  |  Enter to copy key to clipboard" \
    -format s)

# If something was selected, copy the key combo to clipboard
if [[ -n "$CHOICE" ]]; then
    key=$(echo "$CHOICE" | awk '{print $1, $2, $3}' | sed 's/[[:space:]]*$//')
    echo -n "$key" | xclip -selection clipboard 2>/dev/null \
        || echo -n "$key" | xsel --clipboard --input 2>/dev/null
    notify-send "Keybind copied" "$key"
fi
