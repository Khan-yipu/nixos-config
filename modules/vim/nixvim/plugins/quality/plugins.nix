{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-treesitter
    gitsigns-nvim
    conform-nvim
    nvim-lint
  ];
}
