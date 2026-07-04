{ config, pkgs, lib, ... }: let
  # alacritty config file
  alacrittyPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/alacritty";
in 
{
  xdg.configFile = {
    "alacritty".source = config.lib.file.mkOutOfStoreSymlink alacrittyPath;
    "alacritty".force = true;
  };
}
