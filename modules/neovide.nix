{ pkgs, ... }:

{
  # Neovide 图形界面
  home.packages = [
    pkgs.neovide
  ];

  xdg.configFile."neovide/config.toml".text = ''
    fork = true
    frame = "full"
    idle = true
    maximized = false
    srgb = true
    tabs = false
    theme = "auto"
    vsync = true

    [font]
    normal = ["Maple Mono NF CN"]
    size = 14.0
  '';
}

