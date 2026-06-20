{ inputs, pkgs, config, ... }: let 
  dwmPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/dwm";
  yaoc-picom = pkgs.stdenv.mkDerivation rec {
    pname = "picom-yaoc";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "yaocccc";
      repo = "picom";
      rev = "master";        
      sha256 = "sha256-5pHd9y4RENCciwx0yG8Sz4Oi1gPjMFcQ7lBKgRR2NAA=";  # 首次 build 会报错给真 sha256，替换进来
    };

    nativeBuildInputs = with pkgs; [
      meson
      ninja
      pkg-config
      cmake  # 部分子依赖检查用到
    ];

    buildInputs = with pkgs; [
      libev
      libconfig
      pixman
      dbus
      glib
      pcre
      libx11
      libxext
      libxdamage
      libxrandr
      libxcomposite
      libxrender
      libxfixes
      libxinerama
      libxpresent
      libxcb-util
      libxcb-image
      libxcb-render-util
      libxcb
      mesa
      uthash
      libepoxy
    ];

    postPatch = ''
      # 修复：dwm killclient() → picom 在 destroying/unmapped 窗口上收到 size change → SIGABRT
      # yaocccc/picom 不支持 -Ddocs=false，手动去掉 man subdir
      sed -i '1432,1433d' src/win.c
      # 2. 删除 backend.c 中在 destroyed 窗口上的 assert
      sed -i '251d' src/backend/backend.c
      sed -i '/^subdir.*man/d' meson.build
    '';

    meta = {
      description = "Animated picom fork by yaocccc";
      mainProgram = "picom";
    };
  };
in
{
  home.packages = with pkgs; [
    # 安装 dwm 的配套工具
    feh        # 设置壁纸
    # picom 可以放在 packages 里面安装，这样不会自动启动
    # 也可以 通过 services.picom.enable = true 来安装，这样进入 x 会话自动启动
    # picom-pijulius

    /* 这么安装还是会报错
    (picom.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
        pkgs.asciidoc
      ];
    }))
    */
    yaoc-picom

    rofi
    dunst
    pcmanfm
    i3lock-color
    xss-lock
    lemonade
    flameshot
    upower

    xmodmap
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

        # feh --bg-fill ~/Pictures/wallpapers/hope.png
        # fcitx5 &
        flameshot &
    '';
  };

  # Home Manager 也可以管理 X resources 等相关配置
  xresources.extraConfig = ''
    ! 这里可以写 Xresources 配置
    Xft.dpi: 160
  '';
}
