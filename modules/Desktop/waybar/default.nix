{ lib, config, pkgs, ... }: let 
  # waybar config directory
  waybarPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/waybar/waybar-shorin";
  waybarWinLikePath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/waybar/waybar-niri-Win11Like";
in 
{
  /*
  imports = [
    ./waybar.nix
  ];
  */ 

  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar".source = config.lib.file.mkOutOfStoreSymlink waybarPath;
    "waybar".force = true;
    "waybar-niri-Win11Like".source = config.lib.file.mkOutOfStoreSymlink waybarWinLikePath;
    "waybar-niri-Win11Like".force = true;
  };
}
