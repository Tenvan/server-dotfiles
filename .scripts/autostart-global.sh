#!/usr/bin/env bash

function run() {
    if command -v $1 &>/dev/null; then
        #pgrep -u "$USER" -fx "$1" >/dev/null || ($@) &
        if ! pgrep "$1"; then
            $@ &
        fi
    else
        notify-send -t 10000 -u critical "Error Autostart" "Kommando '$1' nicht gefunden"
    fi
}

function restart() {
    killall "$1"
    run $@
}

run ibus-daemon -d -x

#change your keyboard if you need it
run setxkbmap -layout de
run numlockx on

run unclutter --root --timeout 3

#cursor active at boot
run xsetroot -cursor_name left_ptr -bg "#2a2a2a" -fg "#d6d6d6"

sh ~/.scripts/set-wallpaper.sh

#starting utility applications at boot time
run nm-applet
run pamac-tray
run msm_notifier
run radiotray-ng
run kteatime

# killall xbindkeys
restart xbindkeys

# Sound Tray Icons
run start-pulseaudio-x11
run pasystray

run redshift-gtk

run blueman-tray
run blueberry-tray
run blueman-applet

run xscreensaver

killall xfce-polkit
run /usr/lib/xfce-polkit/xfce-polkit
# run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
# run lxqt-policykit-agent

run copyq
restart alttab -n 1

run system-config-printer-applet

killall -q picom
sh $SCRIPTS/picom-toggle-awesome.sh &

CUSTOM_AUTOSTART="$HOME/.autostart-custom"
test -f $CUSTOM_AUTOSTART && sh $CUSTOM_AUTOSTART
