{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    swww
    mpvpaper
    waypaper

    socat
  ];
}
