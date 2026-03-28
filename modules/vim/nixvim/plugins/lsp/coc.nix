{
  programs.nixvim.plugins.coc = {
    enable = true;
    settings = {
      "languageserver" = {
        "sv" = {
          "command" = "verible-verilog-ls";
          "filetypes" = ["systemverilog" "verilog"];
          "rootPatterns" = [".git" "verible.filelist"];
        };
        "rust" = {
          "command" = "rust-analyzer";
          "filetypes" = ["rust"];
          "rootPatterns" = ["Cargo.toml"];
        };
        "clangd" = {
          "command" = "clangd";
          "args" = ["--background-index"];
          "rootPatterns" = ["compile_commands.json" ".vim/" ".git/" ".hg/"];
          "filetypes" = ["c" "cpp" "objc" "objcpp"];
        };
        "metals" = {
          "command" = "metals";
          "filetypes" = ["scala" "sbt"];
          "rootPatterns" = ["build.sbt" "build.sc" "build.mill" ".git"];
        };
        "haskell-language-server" = {
          "command" = "haskell-language-server-wrapper";
          "args" = ["--lsp"];
          "filetypes" = ["haskell" "lhaskell"];
          "rootPatterns" = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml"];
        };
      };
      "suggest.noselect" = true;
      "suggest.enablePreview" = true;
    };
  };
}
