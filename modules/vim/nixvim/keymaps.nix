{
  programs.nixvim.keymaps = [
    { mode = "n"; key = "<leader>t"; action = ":TagbarToggle<CR>"; }
    { mode = "n"; key = "<leader>e"; action = ":NERDTreeToggle<CR>"; }
    { mode = "n"; key = "<C-p>"; action = ":Files<CR>"; }
    { mode = "n"; key = "<leader>b"; action = ":Buffers<CR>"; }

    # CoC 快捷键
    { mode = "n"; key = "gd"; action = "<Plug>(coc-definition)"; options = { silent = true; }; }
    { mode = "n"; key = "gy"; action = "<Plug>(coc-type-definition)"; options = { silent = true; }; }
    { mode = "n"; key = "gi"; action = "<Plug>(coc-implementation)"; options = { silent = true; }; }
    { mode = "n"; key = "gr"; action = "<Plug>(coc-references)"; options = { silent = true; }; }
    { mode = "n"; key = "<leader>rn"; action = "<Plug>(coc-rename)"; }

    # 格式化
    { mode = "x"; key = "<leader>f"; action = "<Plug>(coc-format-selected)"; }
    { mode = "n"; key = "<leader>f"; action = "<Plug>(coc-format-selected)"; }

    # 查看文档
    { mode = "n"; key = "K"; action = ":call ShowDocumentation()<CR>"; options = { silent = true; }; }
  ];
}
