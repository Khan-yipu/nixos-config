{ config, pkgs, ... }: let 
  # vim config directory
  vimPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/";
in
{
  home.packages = with pkgs; [
    vim-full 
    vimPlugins.vim-plug
  ];
  xdg.configFile = {
    "vim".source = config.lib.file.mkOutOfStoreSymlink ./.vimrc;
    # "vim".force = true;
  };
}
