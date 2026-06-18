#!/usr/bin/env bash
:<<!
  屏幕分辨率管理脚本（xrandr 封装）
  针对 1920x1200 内置屏
!

INNER_PORT=eDP-1
_MODE=THREE
MODE=$_MODE

__setbg() {
    feh --randomize --bg-fill ~/Pictures/wallpapers/*.png
}

# 内置屏（1920x1200）
__get_inner_view() {
    case "$MODE" in
        ONE)   echo "--output $INNER_PORT --mode 1920x1200 --pos 0x0" ;;
        LR|LLR) echo "--output $INNER_PORT --mode 1920x1200 --pos 1920x0" ;;
        TB|LTB) echo "--output $INNER_PORT --mode 1920x1200 --pos 0x1080" ;;
        THREE) echo "--output $INNER_PORT --mode 1920x1200 --pos 3640x780" ;;
        *)     echo "--output $INNER_PORT --mode 1920x1200 --pos 0x0" ;;
    esac
}

# 外接屏
__get_outer_view() {
    outport=$1
    outport2=$2
    case "$MODE" in
        LR)  echo "--output $outport --mode 1920x1080 --pos 0x0 --primary" ;;
        TB)  echo "--output $outport --mode 1920x1080 --pos 0x0 --primary" ;;
        LLR) echo "--output $outport --mode 2560x1080 --pos 0x0 --primary" ;;
        LTB) echo "--output $outport --mode 2560x1080 --pos 0x0 --primary" ;;
        THREE)
            echo "--output $outport --mode 1920x1080 --rotate left --pos 0x0 \
                  --output $outport2 --mode 2560x1080 --pos 1080x300 --primary"
            ;;
    esac
}

__get_off_views() {
    for sc in $(xrandr | grep 'connected' | awk '{print $1}'); do
        echo "--output $sc --off"
    done
}

one() {
    MODE=ONE
    xrandr $(__get_off_views) $(__get_inner_view)
    __setbg
}

two() {
    OUTPORT=$(xrandr | grep -v $INNER_PORT | grep -w connected | awk '{print $1}')
    [ -z "$OUTPORT" ] && one && return

    xrandr $(__get_off_views) $(__get_inner_view) $(__get_outer_view $OUTPORT)
    __setbg
}

three() {
    HDMI=$(xrandr | grep -v $INNER_PORT | grep -w connected | grep HDMI | awk '{print $1}')
    DP=$(xrandr | grep -v $INNER_PORT | grep -w connected | grep DP | awk '{print $1}')

    [ -z "$HDMI" ] && one && return

    xrandr $(__get_off_views) $(__get_inner_view) $(__get_outer_view $DP $HDMI)
    __setbg
}

check() {
    CONNECTED=$(xrandr | grep -w connected | wc -l)
    ACTIVE=$(xrandr --listmonitors | sed 1d | wc -l)
    [ "$CONNECTED" -eq "$ACTIVE" ] && return

    case $CONNECTED in
        1) one ;;
        2) two ;;
        3) three ;;
    esac
}

case $1 in
    one) one ;;
    two) two ;;
    three) three ;;
    *) check ;;
esac