{
  programs.nixvim.extraConfigLua = ''
    vim.g.codecompanion_chat_adapter = vim.g.codecompanion_chat_adapter or "copilot"

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

    local function setup_codecompanion(adapter_name)
      require("codecompanion").setup({
        adapters = {
          acp = {
            codex = function()
              return require("codecompanion.adapters").extend("codex", {
                defaults = {
                  auth_method = (vim.env.OPENAI_API_KEY ~= nil and vim.env.OPENAI_API_KEY ~= "") and "openai-api-key" or "chatgpt",
                },
              })
            end,
          },
          http = {
            wataruu = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "https://api.wataruu.me/v1",
                  api_key = "WATARUU_API_KEY",
                  chat_url = "/chat/completions",
                },
                schema = {
                  model = {
                    default = "gpt-4o-mini",
                  },
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = adapter_name,
          },
          inline = {
            adapter = "copilot",
          },
          cmd = {
            adapter = "copilot",
          },
        },
      })
    end

    setup_codecompanion(vim.g.codecompanion_chat_adapter)

    vim.api.nvim_create_user_command("CCUseCopilot", function()
      vim.g.codecompanion_chat_adapter = "copilot"
      setup_codecompanion("copilot")
      vim.notify("CodeCompanion chat adapter: copilot")
    end, {})

    vim.api.nvim_create_user_command("CCUseCodex", function()
      vim.g.codecompanion_chat_adapter = "codex"
      setup_codecompanion("codex")
      vim.notify("CodeCompanion chat adapter: codex")
    end, {})

    vim.api.nvim_create_user_command("CCUseWataruu", function()
      vim.g.codecompanion_chat_adapter = "wataruu"
      setup_codecompanion("wataruu")
      vim.notify("CodeCompanion chat adapter: wataruu")
    end, {})

    vim.api.nvim_create_user_command("CCShowAdapter", function()
      vim.notify("Current CodeCompanion chat adapter: " .. tostring(vim.g.codecompanion_chat_adapter))
    end, {})
  '';
}
