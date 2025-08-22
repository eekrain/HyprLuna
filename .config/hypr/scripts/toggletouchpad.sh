
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi
export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

# get your touchpad id by running hyprctl devices
export HYPRLAND_DEVICE="asue120b:00-04f3:31c0-touchpad"

enable_touchpad() {
    printf "1" >"$STATUS_FILE"
    notify-send -u normal "Touchpad enabled" -i ~/.local/share/icons/touchpad_enabled.svg
    hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" true
}

disable_touchpad() {
    printf "0" >"$STATUS_FILE"
    notify-send -u normal "Touchpad disabled" -i ~/.local/share/icons/touchpad_disabled.svg
    hyprctl keyword "device[$HYPRLAND_DEVICE]:enabled" false
}

last_stat=$(cat "$STATUS_FILE")
if [[ $last_stat == "0" ]]; then
    enable_touchpad
else
    disable_touchpad
fi