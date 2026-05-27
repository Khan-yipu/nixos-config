{
  ...
}:

{
  services.swayidle = {
    enable = true;
    events = {
      "lock" = "niri msg action power-off-monitors && noctalia-shell ipc call lockScreen toggle";
      "unlock" = "niri msg action power-on-monitors";
      "after-resume" = "noctalia-shell ipc call lockScreen toggle";
    };

    timeouts = [
      {
        timeout = 600;
        command = "niri msg action power-off-monitors && noctalia-shell ipc call lockScreen toggle";
      }
    ];
  };
}
