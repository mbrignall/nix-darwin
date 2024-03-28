#!/usr/bin/env zsh

ICON_PADDING_RIGHT=5

case $INFO in
"Alacritty")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Code")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Emacs")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"Google Meet")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON=󰕼
    ;;
"Messages")
    ICON=󰍦
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON=
    ;;
"Slack")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
*)
    ICON=﯂
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
