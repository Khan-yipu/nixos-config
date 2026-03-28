{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nerdtree # 文件树
    vim-gutentags
    vim-airline-themes
  ];
}
