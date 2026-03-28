{
  programs.nixvim.extraConfigLua = ''
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local default_opts = {
      capabilities = capabilities,
    }

    local function setup_if_available(server, opts)
      if lspconfig[server] ~= nil then
        lspconfig[server].setup(opts)
      end
    end

    setup_if_available("clangd", default_opts)
    setup_if_available("rust_analyzer", default_opts)

    setup_if_available("hls", vim.tbl_extend("force", default_opts, {
      filetypes = { "haskell", "lhaskell", "cabal" },
      root_dir = util.root_pattern("hie.yaml", "cabal.project", "stack.yaml", ".git"),
    }))

    setup_if_available("verible", vim.tbl_extend("force", default_opts, {
      filetypes = { "systemverilog", "verilog" },
      root_dir = util.root_pattern("verible.filelist", ".git"),
    }))

    setup_if_available("metals", vim.tbl_extend("force", default_opts, {
      root_dir = util.root_pattern("build.sbt", "build.sc", "build.mill", ".git"),
    }))
  '';
}
