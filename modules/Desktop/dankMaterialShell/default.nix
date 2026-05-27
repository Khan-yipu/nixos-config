{
  pkgs,
  ...
}:

{
  imports = [
    ./niri.nix
    ./swayidle.nix
  ];

  home.packages = with pkgs; [
    app2unit
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;

    niri = {
      enableSpawn = false;
      enableKeybinds = true;
    };
  };

}
