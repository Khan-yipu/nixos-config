{
  programs.nixvim.extraConfigLua = ''
    require("copilot").setup({
      panel = { enabled = false },
      suggestion = { enabled = false },
    })

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
