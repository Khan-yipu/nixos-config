{
  programs.nixvim.extraConfigLua = ''
    local ok_notify, notify = pcall(require, "notify")
    if ok_notify then
      vim.notify = notify
      notify.setup({
        background_colour = "#1f2329",
        timeout = 2500,
        render = "wrapped-compact",
        stages = "fade_in_slide_out",
        top_down = false,
        fps = 60,
      })
    end

    local ok_noice, noice = pcall(require, "noice")
    if ok_noice then
      noice.setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
          progress = { enabled = true },
          signature = { enabled = true },
          hover = { enabled = true },
        },
        messages = {
          enabled = true,
          view = "notify",
          view_warn = "notify",
          view_error = "notify",
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { icon = "" },
            search_down = { icon = " " },
            search_up = { icon = " " },
            filter = { icon = "$" },
            lua = { icon = "" },
            help = { icon = "" },
          },
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              find = "written",
            },
            opts = { skip = true },
          },
        },
        presets = {
          command_palette = true,
          bottom_search = false,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
      })
    end

    local ok_dressing, dressing = pcall(require, "dressing")
    if ok_dressing then
      dressing.setup({
        input = { enabled = true },
        select = { enabled = true },
      })
    end

    local ok_flash, flash = pcall(require, "flash")
    if ok_flash then
      flash.setup({})
    end

    local ok_snacks, snacks = pcall(require, "snacks")
    if ok_snacks then
      snacks.setup({
        input = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      })
    end
  '';
}
