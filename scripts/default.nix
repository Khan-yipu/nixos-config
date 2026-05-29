{ config, pkgs, ... }: let 
  # scripts directory
  scriptsPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/scripts/sh";
in
{
  xdg.configFile = {
    "def-scripts".source = config.lib.file.mkOutOfStoreSymlink scriptsPath;
    "def-scripts".force = true;
  };
}