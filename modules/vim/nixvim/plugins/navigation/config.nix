{
  programs.nixvim.extraConfigLua = ''
    require("telescope").setup({})

    require("trouble").setup({})

    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
      },
    })
  '';
}
