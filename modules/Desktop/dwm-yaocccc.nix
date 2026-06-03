{ inputs, pkgs, config, ... }: let 
  dwmPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/dwm";
in
{
  home.packages = with pkgs; [
    # 安装 dwm 的配套工具
    feh        # 设置壁纸
    # picom 可以放在 packages 里面安装，这样不会自动启动
    # 也可以 通过 services.picom.enable = true 来安装，这样进入 x 会话自动启动
    picom
    rofi
    dunst
    pcmanfm
    i3lock-color
    xss-lock
    lemonade
    flameshot
    upower
  ];

  # services.picom.enable = true; 

  xsession = {
    enable = true;
    windowManager.command = "exec dwm";

    # 可选：在启动 dwm 前执行一些脚本，比如设置壁纸、启动状态栏
    initExtra = ''
        # 例：如果你也用了 yaocccc 的 dwm-scripts
        # dwm_status.sh &
        # nitrogen --restore &
        export DWM=~/nix-setup/nixconfigs/modules/Desktop/dwm

        feh --bg-fill ~/Pictures/wallpapers/hope.png
        fcitx5 &
        flameshot &
    '';
  };

  # Home Manager 也可以管理 X resources 等相关配置
  xresources.extraConfig = ''
    ! 这里可以写 Xresources 配置
  '';
}