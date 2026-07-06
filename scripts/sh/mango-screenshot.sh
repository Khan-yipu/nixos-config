#!/usr/bin/env bash

# 保存目录
SAVE_DIR="$HOME/Pictures/Screenshots"

# 确保目录存在
# mkdir -p "$SAVE_DIR"

# 文件名（带时间戳）
FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$SAVE_DIR/$FILENAME"

# 截图（grim + slurp）
grim -l 0 -g "$(slurp)" - | tee "$FILEPATH" | wl-copy

# 截图成功提示
if [[ $? -eq 0 ]]; then
    notify-send "截图成功" "已保存到 $FILEPATH 并复制到剪贴板"
else
    notify-send "截图失败" "请检查 grim / slurp 是否正常运行"
fi
