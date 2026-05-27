{
  ...
}:

{
  imports = [
    # ./niri.nix
    ./noctalia.nix
    ./swayidle.nix
  ];

  xdg.configFile = {
    "niri/custom.kdl".source = ./dotfiles/custom.kdl;
  };
}
