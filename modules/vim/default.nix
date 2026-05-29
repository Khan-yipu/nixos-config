{ config, pkgs, ... }: let
  # vim config directory
  vimPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/dotfiles";
in
{
  home.packages = with pkgs; [
    vim-full
    vimPlugins.vim-plug
  ];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim-addon-nix
      gruvbox
      vim-table-mode
      vim-visual-multi
      vim-surround
      ultisnips
      vim-expand-region
    ];
    extraConfig = builtins.readFile ./dotfiles/vimrc;
  };

  xdg.configFile = {
    "vim".source = config.lib.file.mkOutOfStoreSymlink vimPath;
    # "vim".force = true;
  };
}
