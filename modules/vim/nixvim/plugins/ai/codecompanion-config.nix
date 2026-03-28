{
  programs.nixvim.extraConfigLua = ''
    require("copilot").setup({
      panel = { enabled = false },
      suggestion = { enabled = false },
    })

    local ok_render_markdown, render_markdown = pcall(require, "render-markdown")
    if ok_render_markdown then
      render_markdown.setup({
        file_types = { "markdown", "codecompanion" },
      })
    end

    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
    })
  '';
}
