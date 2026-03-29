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
        "<leader>w" = { name = "+window"; };
        "<leader>x" = { name = "+problems"; };

        "<leader>aa" = "Actions";
        "<leader>ac" = "Chat";
        "<leader>a1" = "Use Copilot";
        "<leader>a2" = "Use Codex";
        "<leader>a4" = "Use OpenCode";
        "<leader>as" = "Show Adapter";
        "<leader>ff" = "Files";
        "<leader>fg" = "Grep";
        "<leader>fb" = "Buffers";
        "<leader>fr" = "Recent";
        "<leader>nn" = "History";
        "<leader>nl" = "Last";
        "<leader>nd" = "Dismiss";
        "<leader>ux" = "Noice";
        "<leader>us" = "Snacks Picker";
        "<leader>ud" = "Dashboard";
        "<leader>wh" = "Go Left";
        "<leader>wj" = "Go Down";
        "<leader>wk" = "Go Up";
        "<leader>wl" = "Go Right";
        "<leader>wv" = "Split Vertical";
        "<leader>ws" = "Split Horizontal";
        "<leader>wq" = "Close Window";
        "<leader>wo" = "Only Window";
        "<leader>tf" = "Everforest";
        "<leader>tc" = "Catppuccin";
        "<leader>tt" = "Tokyo Night";
        "<leader>tk" = "Kanagawa";
        "<leader>tg" = "Gruvbox";
      };
    };
  };

  programs.nixvim.extraConfigLua = ''
    local ok_wk, wk = pcall(require, "which-key")
    if ok_wk then
      wk.add({
        { "<leader>a", group = "AI", mode = "n" },
        { "<leader>f", group = "Find", mode = "n" },
        { "<leader>l", group = "LSP", mode = "n" },
        { "<leader>n", group = "Notify", mode = "n" },
        { "<leader>t", group = "Theme", mode = "n" },
        { "<leader>u", group = "UI", mode = "n" },
        { "<leader>w", group = "Window", mode = "n" },
        { "<leader>x", group = "Problems", mode = "n" },

        { "<leader>aa", desc = "CodeCompanion Actions", mode = "n" },
        { "<leader>ac", desc = "CodeCompanion Chat", mode = "n" },
        { "<leader>a1", desc = "Use Copilot", mode = "n" },
        { "<leader>a2", desc = "Use Codex", mode = "n" },
        { "<leader>a4", desc = "Use OpenCode", mode = "n" },
        { "<leader>as", desc = "Show Adapter", mode = "n" },

        { "<leader>ff", desc = "Find Files", mode = "n" },
        { "<leader>fg", desc = "Live Grep", mode = "n" },
        { "<leader>fb", desc = "Find Buffers", mode = "n" },
        { "<leader>fr", desc = "Recent Files", mode = "n" },

        { "<leader>nn", desc = "Noice History", mode = "n" },
        { "<leader>nl", desc = "Noice Last", mode = "n" },
        { "<leader>nd", desc = "Noice Dismiss", mode = "n" },

        { "<leader>ux", desc = "Open Noice", mode = "n" },
        { "<leader>us", desc = "Snacks Files", mode = "n" },
        { "<leader>ud", desc = "Open Dashboard", mode = "n" },

        { "<leader>wh", desc = "Window Left", mode = "n" },
        { "<leader>wj", desc = "Window Down", mode = "n" },
        { "<leader>wk", desc = "Window Up", mode = "n" },
        { "<leader>wl", desc = "Window Right", mode = "n" },
        { "<leader>wv", desc = "Split Vertical", mode = "n" },
        { "<leader>ws", desc = "Split Horizontal", mode = "n" },
        { "<leader>wq", desc = "Close Window", mode = "n" },
        { "<leader>wo", desc = "Only Window", mode = "n" },

        { "<leader>tf", desc = "Theme Everforest", mode = "n" },
        { "<leader>tc", desc = "Theme Catppuccin", mode = "n" },
        { "<leader>tt", desc = "Theme TokyoNight", mode = "n" },
        { "<leader>tk", desc = "Theme Kanagawa", mode = "n" },
        { "<leader>tg", desc = "Theme Gruvbox", mode = "n" },
      })
    end
  '';
}
