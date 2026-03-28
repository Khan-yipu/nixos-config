{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    plenary-nvim
    trouble-nvim
    neo-tree-nvim
    nui-nvim
    nvim-web-devicons
  ];
}
