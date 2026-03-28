{
  programs.nixvim.plugins = {
    # 状态栏
    airline = {
      enable = true;
      settings = {
        theme = "everforest";
        powerline_fonts = 1;
      };
    };

    # Nix 语言支持
    nix.enable = true;

    # 模糊搜索 (FZF)
    fzf-vim.enable = true;

    # 代码大纲
    tagbar.enable = true;

    # 图标支持 (替代 vim-devicons)
    web-devicons.enable = true;

    # 记住上次编辑位置
    lastplace.enable = true;

    # 快捷键提示 (WhichKey)
    which-key = {
      enable = true;
      registrations = {
        "<leader>e" = "Explorer";
        "<leader>b" = "Buffers";
        "<leader>t" = "Tagbar";
        "<leader>f" = "Format";
        "<leader>r" = { name = "+refactor"; };
        "<leader>rn" = "Rename";
      };
    };
  };
}
