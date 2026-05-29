{
  ...
}:

{
  imports = [
    ./waypaper.nix
  ];

  xdg.configFile = {
    "waypaper/config.ini".source = ./config.ini;
  };
}
