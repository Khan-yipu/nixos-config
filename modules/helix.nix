{
  pkgs,
  lib,
  ...
}:

{
  home.packages = [ pkgs.nixd ];

  programs.helix = {
    enable = true;
    settings = {
      # theme = lib.mkDefault "transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt;
          language-servers = [
            "nixd"
          ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "pylsp"
          ];
        }
      ];
      language-server = {
        nixd.command = lib.getExe pkgs.nixd;
        pylsp.command = lib.getExe pkgs.python312Packages.python-lsp-server;
      };
    };

    # themes = {
    #   transparent = {
    #     "inherits" = "ayu_mirage";
    #     "ui.background" = { };
    #     "ui.text" = { };
    #     "ui.help" = { };
    #     "ui.menu" = { };
    #     "ui.statusline" = { };
    #   };
    # };
  };
}
