{ config, ... }: let
  # matugen config directory
  matugenPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/matugen/";
in
{
  xdg.configFile = {
    "matugen".source = config.lib.file.mkOutOfStoreSymlink matugenPath;
    "matugen".force = true;
  };
}
