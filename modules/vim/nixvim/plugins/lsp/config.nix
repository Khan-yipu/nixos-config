{
  programs.nixvim.extraConfigLua = ''
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    local function setup_and_enable(server, opts)
      vim.lsp.config(server, vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, opts or {}))
      vim.lsp.enable(server)
    end

    setup_and_enable("clangd")
    setup_and_enable("rust_analyzer")

    setup_and_enable("hls", {
      filetypes = { "haskell", "lhaskell", "cabal" },
      root_markers = { "hie.yaml", "cabal.project", "stack.yaml", ".git" },
    })

    setup_and_enable("verible", {
      filetypes = { "systemverilog", "verilog" },
      root_markers = { "verible.filelist", ".git" },
    })

    setup_and_enable("metals", {
      root_markers = { "build.sbt", "build.sc", "build.mill", ".git" },
    })
  '';
}
