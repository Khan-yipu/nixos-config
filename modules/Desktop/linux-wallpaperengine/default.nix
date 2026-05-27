{
  pkgs,
  config,
  ...
}:

{
  home.packages = with pkgs; [
    linux-wallpaperengine
  ];

  programs.niri.settings = {
    spawn-at-startup = [
      { sh = "${config.xdg.dataHome}/autostart/linux-wallpaperengine.sh"; }
    ];
  };
}
