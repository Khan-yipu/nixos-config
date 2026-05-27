{
  pkgs,
  ...
}:

{
  programs.prismlauncher = {
    enable = true;
    extraPackages = [
      pkgs.javaPackages.compiler.temurin-bin.jre-8
      pkgs.javaPackages.compiler.temurin-bin.jre-17
      pkgs.javaPackages.compiler.temurin-bin.jre-21
      pkgs.javaPackages.compiler.temurin-bin.jre-25
    ];
  };
}
