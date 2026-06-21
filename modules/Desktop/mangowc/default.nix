{ inputs, pkgs, config, ... }: let 
  # mangowc config directory
  MANGOWC = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/Desktop/mangowc/dotfiles";
in
{
  home.packages = with pkgs; [
    slurp
    grim
    wmenu
    # swaync
  ];

  xdg.configFile = {
    "mango".source = config.lib.file.mkOutOfStoreSymlink MANGOWC;
  };
}
