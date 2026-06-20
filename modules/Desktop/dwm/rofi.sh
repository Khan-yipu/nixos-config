# 打印菜单
call_menu() {
    echo ' set wallpaper'
    echo '艹 update statusbar'
    # [ "$(ps aux | grep -v grep | grep daed)" ] && echo ' close daed' || echo ' open daed'
    # [ "$(ps aux | grep picom | grep -v 'grep\|rofi\|nvim')" ] && echo ' close picom' || echo ' open picom'
    if pgrep -x daed >/dev/null; then
        echo ' close daed'
    else
        echo ' open daed'
    fi

    if pgrep -x picom >/dev/null; then
        echo 'close picom'
    else
        echo 'open picom'
    fi
}

# 执行菜单
execute_menu() {
    echo "DEBUG: [$1]" >> ~/menu_debug.log
    case "$1" in
        ' set wallpaper')
            feh --randomize --bg-fill ~/Pictures/wallpapers/*.png
            ;;
        ' update statusbar')
            "$DWM/statusbar/statusbar.sh" updateall >/dev/null 2>&1
            ;;
        'open picom')
            pkill -x picom
            picom --config "$DWM/scripts/config/picom.conf" >/dev/null 2>&1 &
            ;;
        'close picom')
            pkill -x picom
            ;;
    esac
}

choice="$(call_menu | rofi -dmenu -p "" -no-lazy-grab -show drun -modi drun -theme $DWM/scripts/config/rofi.rasi | tr -d '\n')"
[ -n "$choice" ] || exit
execute_menu "$choice"
