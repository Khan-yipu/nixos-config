{
  programs.nixvim.plugins = {
    # 状态栏
    airline = {
      enable = true;
      settings = {
        powerline_fonts = 1;
      };
    };

    # Nix 语言支持
    nix.enable = true;

    # 图标支持 (替代 vim-devicons)
    web-devicons.enable = true;

    # 记住上次编辑位置
    lastplace.enable = true;

    # 快捷键提示 (WhichKey)
    which-key = {
      enable = true;
      registrations = {
        "<leader>a" = { name = "+ai"; };
        "<leader>e" = "Explorer";
        "<leader>f" = { name = "+find"; };
        "<leader>l" = { name = "+lsp"; };
        "<leader>n" = { name = "+notify"; };
        "<leader>t" = { name = "+theme"; };
        "<leader>u" = { name = "+ui"; };
        "<leader>x" = { name = "+problems"; };

        "<leader>aa" = "Actions";
        "<leader>ac" = "Chat";
        "<leader>a1" = "Use Copilot";
        "<leader>a2" = "Use Codex";
        "<leader>a3" = "Use Wataruu";
        "<leader>as" = "Adapter Status";
        "<leader>ff" = "Files";
        "<leader>fg" = "Grep";
        "<leader>fb" = "Buffers";
        "<leader>fr" = "Recent";
        "<leader>nn" = "History";
        "<leader>nl" = "Last";
        "<leader>nd" = "Dismiss";
        "<leader>ux" = "Noice";
        "<leader>us" = "Snacks Picker";
        "<leader>tf" = "Everforest";
        "<leader>tc" = "Catppuccin";
        "<leader>tt" = "Tokyo Night";
        "<leader>tk" = "Kanagawa";
        "<leader>tg" = "Gruvbox";
      };
    };
  };
}
