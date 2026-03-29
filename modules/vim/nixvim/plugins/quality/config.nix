{
  programs.nixvim.extraConfigLua = ''
    local ok_ts, ts = pcall(require, "nvim-treesitter")
    if ok_ts and ts.setup then
      ts.setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end

    local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
    if ok_gitsigns then
      gitsigns.setup({})
    end

    local ok_conform, conform = pcall(require, "conform")
    if ok_conform then
      conform.setup({
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
    end

    local ok_lint, lint = pcall(require, "lint")
    if ok_lint then
      lint.linters_by_ft = {
        c = { "clangtidy" },
        cpp = { "clangtidy" },
        nix = { "statix" },
        python = { "ruff" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  '';
}
