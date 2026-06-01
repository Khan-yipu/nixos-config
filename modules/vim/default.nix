{ config, pkgs, ... }: let
  # vim config directory
  vimAutoloadPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/dotfiles/autoload";
  vimrcFile = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/vimrc";
in
{
  home.packages = with pkgs; [
    vim-full
    # vimPlugins.vim-plug
  ];

  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink vimrcFile;
  home.file.".vim/autoload".source = config.lib.file.mkOutOfStoreSymlink vimAutoLoadPath;

  /*
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
  */
}
