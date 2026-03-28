{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    snacks-nvim
    flash-nvim
    noice-nvim
    nvim-notify
    nui-nvim
    dressing-nvim
    catppuccin-nvim
    tokyonight-nvim
    kanagawa-nvim
    gruvbox-nvim
  ];
}
