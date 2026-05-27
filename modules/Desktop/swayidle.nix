{
  pkgs,
  ...
}:

{
  services.swayidle = {
    enable = true;
    events = {
      "lock" =
        "${pkgs.niri.out}/bin/niri msg action power-off-monitors && ${pkgs.gtklock.out}/bin/gtklock -d";
      "unlock" = "${pkgs.niri.out}/bin/niri msg action power-on-monitors";
      "after-resume" = "${pkgs.gtklock.out}/bin/gtklock -d";
    };
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.niri.out}/bin/niri msg action power-off-monitors && ${pkgs.gtklock.out}/bin/gtklock -d";
      }
    ];
  };
}
