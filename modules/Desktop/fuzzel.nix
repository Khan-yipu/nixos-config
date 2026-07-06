{ pkgs, lib, ... }: let 
  # fuzzel config directory
  fuzzelPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/fuzzel";
in
{
  xdg.configFile = {
    "fuzzel".source = config.lib.file.mkOutOfStoreSymlink fuzzelPath;
    "fuzzel".force = true;
  };
  /*
  home.packages = with pkgs; [
    cliphist
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "monospace:size=16";
        icons-enabled = "no";
        layer = "overlay";
        line-height = "16";
        terminal = "kitty";
      };
      border = {
        width = "4";
        radius = "12";
      };
    };
  };
  */
}
