{
  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options = { silent = true; }; }

    # Telescope
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<CR>"; options = { silent = true; }; }

    # 原生 LSP
    { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "gi"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "gr"; action = "<cmd>Telescope lsp_references<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>lr"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>la"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>ld"; action = "<cmd>Telescope diagnostics bufnr=0<CR>"; options = { silent = true; }; }

    # 诊断与问题列表
    { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<CR>"; options = { silent = true; }; }

    # 格式化
    { mode = "n"; key = "<leader>lf"; action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>"; options = { silent = true; }; }
  ];
}
