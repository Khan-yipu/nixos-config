{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    # inputs.dms.homeModules.niri  # 由 modules/Desktop/dankMaterialShell/niri.nix 单独管理
  ];

  home.packages = with pkgs; [
    app2unit
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };

  /*
  programs.dank-material-shell.niri = {
    enableSpawn = true;
    enableKeybinds = false;
    includes.enable = false;
  };
  */
}