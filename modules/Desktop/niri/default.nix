{ config, ... }: let 
  # niri config directory
  niri-config = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/niri/dotfiles/config.kdl";
  niri-custom = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/niri/dotfiles/custom.kdl";
in
{
  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink niri-config;
    "niri/custom.kdl".source = config.lib.file.mkOutOfStoreSymlink niri-custom;

    /* 以下的方式也可以，但是不太方便配置的调试
    "niri/config.kdl".source = ./dotfiles/config.kdl;
    "niri/config.kdl".force = true;
    "niri/custom.kdl".force = true;
    */
  };
}
