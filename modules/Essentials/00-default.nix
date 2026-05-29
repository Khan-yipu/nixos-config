{
  pkgs,
  ...
}:

{
  imports = [
    # ./chromium.nix
    # ./zen.nix  # zen-browser home-manager option doesn't exist

    ./wps-office/default.nix
    # ./fcitx5.nix
  ];
  home.packages = with pkgs; [
    /*
    (libreoffice.overrideAttrs {
      variant = "fresh";
      withHelp = false;
      kdeIntegration = false;
      withJava = false;

      langs = [
        "en-GB"
        "en-US"
        "zh-CN"
      ];

      noto-fonts = sarasa-gothic;
      noto-fonts-lgc-plus = sarasa-gothic;
      noto-fonts-cjk-sans = sarasa-gothic;
    })
    */

    obsidian
    # gimp3-with-plugins

    (qq.override {
      commandLineArgs = "--enable-wayland-ime --wayland-text-input-version=3";
    })

    wechat
    /*
    (wechat.overrideAttrs {
    src = fetchurl {
      url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage" ;
      hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
    };
    })
    */

    # telegram-desktop
  ];
}
