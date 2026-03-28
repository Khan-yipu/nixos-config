{
  programs.nixvim.extraConfigLua = ''
    local ok_notify, notify = pcall(require, "notify")
    if ok_notify then
      vim.notify = notify
      notify.setup({
        background_colour = "#1f2329",
        timeout = 2500,
        render = "wrapped-compact",
      })
    end

    local ok_noice, noice = pcall(require, "noice")
    if ok_noice then
      noice.setup({
        lsp = {
          progress = { enabled = true },
          signature = { enabled = true },
          hover = { enabled = true },
        },
        messages = { enabled = true },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        presets = {
          command_palette = true,
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
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      })
    end
  '';
}
