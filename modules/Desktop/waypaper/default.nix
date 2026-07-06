{ config, ... }: let
  # waypaper config directory
  waypaperConfig = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/waypaper/config.ini";
in
{
  imports = [
    ./waypaper.nix
  ];
  xdg.configFile = {
    "waypaper/config.ini".source = config.lib.file.mkOutOfStoreSymlink waypaperConfig;
    "waypaper/config.ini".force = true;
  };
  /*
  xdg.configFile = {
    "waypaper/config.ini".source = ./config.ini;
    "waypaper/config.ini".force = true;
  };
  */
}
