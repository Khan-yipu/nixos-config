# 打印菜单
call_menu() {
    echo ' set wallpaper'
    echo '艹 update statusbar'
    [ "$(ps aux | grep -v grep | grep daed)" ] && echo ' close daed' || echo ' open daed'
    [ "$(ps aux | grep picom | grep -v 'grep\|rofi\|nvim')" ] && echo ' close picom' || echo ' open picom'
}

# 执行菜单
execute_menu() {
    case $1 in
        ' set wallpaper')
            feh --randomize --bg-fill ~/Pictures/wallpapers/*.png
            ;;
        '艹 update statusbar')
            coproc ($DWM/statusbar/statusbar.sh updateall > /dev/null 2>&1)
            ;;
        ' open daed')
            coproc (sudo systemctl start daed > /dev/null && $DWM/statusbar/statusbar.sh updateall > /dev/null)
            ;;
        ' close daed')
            coproc (sudo systemctl stop daed > /dev/null && $DWM/statusbar/statusbar.sh updateall > /dev/null)
            ;;
        'open picom')
            coproc (picom --config $DWM/scripts/config/picom.conf > /dev/null 2>&1)
            ;;
        'close picom')
            pkill -x picom >/dev/null 2>&1
            ;;
    esac
}

execute_menu "$(call_menu | rofi -dmenu -p "")"
