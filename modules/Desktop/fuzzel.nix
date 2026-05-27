{
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    cliphist
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "monospace:size=16";
        icons-enabled = "no";
        layer = "overlay";
        line-height = "16";
        terminal = "kitty";
      };
      border = {
        width = "4";
        radius = "12";
      };
    };
  };
}
