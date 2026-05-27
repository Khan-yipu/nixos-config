{
  pkgs,
  ...
}:

{
  imports = [
    ./lutris.nix
    # ./prismlauncher.nix  # prismlauncher home-manager option doesn't exist
  ];

  home.packages = with pkgs; [
    heroic

    mangohud
    protonup-rs
  ];
}
