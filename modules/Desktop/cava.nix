{ pkgs, lib, config, ... }: let 
  # cava config directory
  cavaPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/cava";
in
{
  xdg.configFile = {
    "cava".source = config.lib.file.mkOutOfStoreSymlink cavaPath;
    "cava".force = true;
  };
}
