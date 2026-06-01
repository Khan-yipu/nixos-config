{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    # 如果是使用 flake 安装的 niri, 可以导入下面一行使得 dms 与 Niri 集成
    # inputs.dms.homeModules.niri
  ];

  home.packages = with pkgs; [
    app2unit
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = false;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };

  /* 如果是使用 flake 安装的 niri, 可以有以下的选项。
  programs.dank-material-shell.niri = {
    enableSpawn = true;
    enableKeybinds = false;
    includes.enable = false;
  };
  */
}