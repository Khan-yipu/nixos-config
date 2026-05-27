{
  ...
}:

{
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      sort = "-time";
      layer = "overlay";
      width = 300;
      height = 500;
      padding = 10;
      margin = "10,10,10,10";
      border-size = 3;
      border-radius = 10;
      icons = 1;
      icon-path = "~/.nix-profile/share/icons/Papirus-Dark";
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = 1;

      "urgency=high" = {
        default-timeout = 0;
      };

      "category=mpd" = {
        default-timeout = 2000;
        group-by = "category";
      };

      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
