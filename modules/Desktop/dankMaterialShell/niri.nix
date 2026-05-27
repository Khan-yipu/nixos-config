{
  lib,
  ...
}:

{
  programs.niri.settings = {
    environment = {
      DMS_DISABLE_MATUGEN = "1";
    };

    layout = {
      gaps = lib.mkForce 12;

      border = {
        enable = false;
        width = 2;
      };
    };
    
    binds = {
      "Mod+D" = {
        hotkey-overlay.title = "打开搜索";
        repeat = false;
        action.spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
      };
    };
  };
}
