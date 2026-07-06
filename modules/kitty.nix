{ config, pkgs, lib, ...  }: let
  # kitty config directory
  kittyPath = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/kitty/custom";
  kittyConfig = "${config.home.homeDirectory}/nix-setup/nixconfigs/modules/kitty/kitty.conf";
in
{
  programs.kitty.enable = true;
  xdg.configFile = {
    "kitty/custom".source = config.lib.file.mkOutOfStoreSymlink kittyPath;
    "kitty/custom".force = true;
    "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink kittyConfig;
    "kitty/kitty.conf".force = true;
  };

  /*
  dconf = {
    settings = {
      "org/gnome/desktop/applications/terminal" = {
        exec = lib.mkForce "kitty";
      };
      "org/cinnamon/desktop/applications/terminal" = {
        exec = lib.mkForce "kitty";
      };
    };
  };

  programs.kitty = {
    font = {
      # name = "FiraCode Nerd Font Mono";
      name = "Iosevka";
      size = 22;
    };

    enableGitIntegration = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    settings = {
      dynamic_background_opacity = true;
      background_opacity = "0.5";
      cursor_shape = "beam";
      background_blur = 10;
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;
    };
  };
  */
}
