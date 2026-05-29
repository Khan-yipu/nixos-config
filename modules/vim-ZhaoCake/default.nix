{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./nixvim
  ];
}
