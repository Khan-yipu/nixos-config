{ config, pkgs, ... }: let 
  # yazi config directory
  yaziPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/yazi/dotfiles";
in
{
  xdg.configFile = {
    "yazi".source = config.lib.file.mkOutOfStoreSymlink yaziPath;
    "yazi".force = true;
  };
}
