{
  programs.nixvim.extraConfigLua = ''
    local ok_dashboard, dashboard = pcall(require, "dashboard")
    if ok_dashboard then
      dashboard.setup({
        theme = "hyper",
        config = {
          week_header = {
            enable = false,
          },
          project = {
            enable = true,
            limit = 5,
          },
          mru = {
            limit = 8,
          },
          shortcut = {
            {
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              desc = "Chat",
              group = "Label",
              action = "CodeCompanionChat",
              key = "c",
            },
            {
              desc = "Themes",
              group = "Label",
              action = "Telescope colorscheme",
              key = "t",
            },
          },
          packages = { enable = false },
          preview = {
            command = "chafa",
            file_path = vim.fn.expand("~/.nixconfigs/assets/asuka.jpg"),
            file_width = 72,
            file_height = 18,
          },
          footer = { "Nixvim dashboard ready." },
        },
      })
    end
  '';
}
