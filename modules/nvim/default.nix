{ config, pkgs, ... }: let 
  # nvim config directory
  nvimPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/nvim";
in
{
  home.packages = with pkgs; [
    neovide
    neovim
  ];
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
    "nvim".force = true;
  };
}
