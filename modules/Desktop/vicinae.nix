{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    app2unit
  ];

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };

    settings = {
      closeOnFocusLoss = false;
      faviconService = "twenty";

      font = {
        size = 10.5;
      };

      keybinding = "default";
      popToRootOnClose = true;

      rootSearch = {
        searchFiles = false;
      };

      theme = {
        iconTheme = "Papirus-Dark";
        name = "vicinae-dark";
      };

      window = {
        csd = true;
        opacity = 0.98;
        rounding = 10;
      };
    };
  };
}
