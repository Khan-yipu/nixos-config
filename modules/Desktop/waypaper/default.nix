{
  ...
}:

{
  imports = [
    ./waypaper.nix
  ];

  xdg.configFile = {
    "waypaper/config.ini".source = ./config.ini;
    "waypaper/config.ini".force = true;
  };
}
