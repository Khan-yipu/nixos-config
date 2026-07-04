{
  lib,
  ...
}:

{

  programs.waybar = {
    enable = true;
    # systemd.enable = true;
    
    style = lib.mkAfter ''
      * {
          /* font-family: "Iosevka Nerd Font Propo"; */
          font-family: "Iosevka";
          /* font-family: "FiraCode Nerd Font Mono"; */
          font-weight: 500;
          font-size: 20px;
          border-radius: 18px;
          text-shadow: none;
          transition: background 0.2s ease, color 0.2s ease;
      }

      window#waybar {
          background-color: alpha(@base00, 0.92);
          padding: 4px 10px;
          border-top-left-radius: 6px;
          border-top-right-radius: 6px;
          border-bottom: none;
          font-family: inherit;
      }

      .modules-left,
      .modules-center,
      .modules-right {
          background: transparent;
          padding: 0 6px;
          margin: 0;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      tooltip {
          color: @base02;
          font-family: "Sarasa Gothic SC";
          font-size: 10px;
          border-radius: 8px;
          padding: 6px 8px;
          background-color: alpha(@base00, 0.9);
      }

      #custom-lock,
      #custom-poweroff,
      #custom-reboot,
      #custom-search,
      #custom-hibernate,
      #custom-caffeine,
      #workspaces button,
      #tray,
      #backlight,
      #battery,
      #cpu,
      #memory,
      #network,
      #wireplumber,
      #wlr-taskbar,
      #clock {
          border-radius: 10px;
          color: @base07;
          padding: 0px 4px;
          margin: 8px 2px;
      }

      #battery { color: @base0C; }
      #clock { color: @base05; }
      #cpu { color: @base08; }
      #backlight { color: @base0A; }
      #memory { color: @base0E; }
      #wireplumber { color: @base0B; }
      #network { color: @base0C; }
      #custom-lock { color: @base0A; }
      #custom-poweroff { color: @base08; }
      #custom-reboot { color: @base0C; }
      #custom-hibernate { color: @base0B; }
      #custom-caffeine { color: @base09; }

      #workspaces button {
          background: transparent;
          transition: background 0.2s ease, color 0.2s ease;
      }

      #workspaces button:hover {
          background-color: alpha(@base07, 0.1);
      }

      #workspaces button.focused {
          background-color: alpha(@base07, 0.2);
          color: @base0D;
      }
    '';
  };
}
