{
  pkgs,
  ...
}:

{
  imports = [
    ./dankMaterialShell/default.nix
    # ./linux-wallpaperengine/default.nix
    ./niri/default.nix
    # ./noctalia/default.nix
    ./rime/default.nix
    ./waybar/default.nix
    ./waypaper/default.nix

    # ./fuzzel.nix
    ./mako.nix
    ./swayidle.nix
    ./vicinae.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    coppwr
    easyeffects

    lxqt.pcmanfm-qt
    lxqt.lxqt-archiver

    mpv
    nomacs

    swaybg
    imagemagick
    libnotify

    labwc
  ];
}
