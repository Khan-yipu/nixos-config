{ config, pkgs, lib, ... }: let
  # vim config directory
  vimPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/dotfiles";
  vimrcFile = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/vim/vimrc";

  # 需要忽略的文件/目录列表
  ignoreList = [
    "plugged"
    ".netrwhist"
  ];

  # dotfiles 目录下的文件列表（排除 ignoreList）
  dotfiles = [
    "autoload"
    "compile.vim"
    "Ctemplate.c"
    "snippits.vim"
    "Ultisnips"
  ];
in
{
  home.packages = with pkgs; [
    vim-full
    # vimPlugins.vim-plug
  ];

  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink vimrcFile;

  # 创建空的 .vim 目录

  # 手动 symlink 每个需要管理的文件
  home.file.".vim/autoload".source = config.lib.file.mkOutOfStoreSymlink "${vimPath}/autoload";
  home.file.".vim/compile.vim".source = config.lib.file.mkOutOfStoreSymlink "${vimPath}/compile.vim";
  home.file.".vim/Ctemplate.c".source = config.lib.file.mkOutOfStoreSymlink "${vimPath}/Ctemplate.c";
  home.file.".vim/snippits.vim".source = config.lib.file.mkOutOfStoreSymlink "${vimPath}/snippits.vim";
  home.file.".vim/Ultisnips".source = config.lib.file.mkOutOfStoreSymlink "${vimPath}/Ultisnips";

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
