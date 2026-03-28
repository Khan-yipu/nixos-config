{
  programs.nixvim.extraConfigLua = ''
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
    })

    require("gitsigns").setup({})

    require("conform").setup({
      formatters_by_ft = {
        nix = { "nixpkgs_fmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    require("lint").linters_by_ft = {
      c = { "clangtidy" },
      cpp = { "clangtidy" },
      nix = { "statix" },
      python = { "ruff" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  '';
}
