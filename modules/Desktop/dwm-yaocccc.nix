{ inputs, pkgs, config, ... }:

{
  xsession = {
    enable = true;
    windowManager.command = "exec dwm";

    # 可选：在启动 dwm 前执行一些脚本，比如设置壁纸、启动状态栏
    initExtra = ''
        # 例：如果你也用了 yaocccc 的 dwm-scripts
        # dwm_status.sh &
        # nitrogen --restore &
    '';
  };

  # Home Manager 也可以管理你的 X resources 等相关配置
  xresources.extraConfig = ''
    ! 这里可以写你的 Xresources 配置
  '';

  home.packages = with pkgs; [
    # 这里不需要再写 dwm，因为它已经在系统级被安装了
    # 但你可以安装 dwm 的配套工具
    feh        # 设置壁纸
    picom      # 终端透明等
  ];
}