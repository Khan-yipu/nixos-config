{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  imports = [
    ./opts.nix
    ./globals.nix
    ./colorscheme.nix
    ./hotpot.nix
    ./plugins
    ./extra-plugins.nix
    ./keymaps.nix
    ./extra-config.nix
  ];
}
