{
  pkgs,
  ...
}:

{
  xdg.dataFile = {
    "applications/wps-office-et.desktop".source = ./dotfiles/wps-office-et.desktop;
    "applications/wps-office-pdf.desktop".source = ./dotfiles/wps-office-pdf.desktop;
    "applications/wps-office-prometheus.desktop".source = ./dotfiles/wps-office-prometheus.desktop;
    "applications/wps-office-wpp.desktop".source = ./dotfiles/wps-office-wpp.desktop;
    "applications/wps-office-wps.desktop".source = ./dotfiles/wps-office-wps.desktop;
  };

  home.packages = with pkgs; [ wpsoffice-cn ];
}
