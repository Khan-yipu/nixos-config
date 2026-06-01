{
  pkgs,
  ...
}:

{
  imports = [
    ./lutris.nix
    # ./prismlauncher.nix  
  ];

  home.packages = with pkgs; [
    heroic

    mangohud
    protonup-rs
  ];
}
