{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # inputs.dms.homeModules.dank-material-shell
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    enableReleaseChecks = false;
    overlays.enable = true;
    targets.plymouth.enable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    override = {
      base04 = "#676c71";
    };

    polarity = "dark";

    fonts = {
      serif = config.stylix.fonts.sansSerif;

      sansSerif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa Gothic SC";
      };

      monospace = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF CN";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 11;
      };
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;

      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    opacity = {
      desktop = 0.9;
      popups = 0.95;
      terminal = 0.95;
    };
  };
}
