{
  ...
}:

{
  imports = [
    ./waybar.nix
  ];

  xdg.configFile = {
    "waybar/config.jsonc".source = ./dotfiles/waybar-config.jsonc;
  };
}
