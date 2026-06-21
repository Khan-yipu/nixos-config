{ config, pkgs, lib, ... }: let
  # dolphin menu entry config
  dolphin_menu_entry = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/applications.menu";
in
{
  xdg.configFile = {
    "menus/applications.menu".source = config.lib.file.mkOutOfStoreSymlink dolphin_menu_entry;
    "menus/applications.menu".force = true;
  };
}
