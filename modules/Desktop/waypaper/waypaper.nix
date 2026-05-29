{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # swww -> awww
    awww
    mpvpaper
    waypaper

    socat
  ];
}
