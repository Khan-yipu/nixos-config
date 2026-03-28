{
  programs.nixvim.extraConfigLua = ''
    vim.g.codecompanion_chat_adapter = vim.g.codecompanion_chat_adapter or "copilot"
    vim.g.codecompanion_copilot_model = vim.g.codecompanion_copilot_model or "gpt-5.3-codex"
    vim.g.codecompanion_codex_model = vim.g.codecompanion_codex_model or "gpt-5.3-codex"
    vim.g.codecompanion_wataruu_model = vim.g.codecompanion_wataruu_model or "gpt-5.4"

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
      local chat_adapter
      if adapter_name == "copilot" then
        chat_adapter = { name = "copilot", model = vim.g.codecompanion_copilot_model }
      elseif adapter_name == "codex" then
        chat_adapter = { name = "codex", model = vim.g.codecompanion_codex_model }
      elseif adapter_name == "wataruu" then
        chat_adapter = { name = "wataruu", model = vim.g.codecompanion_wataruu_model }
      else
        chat_adapter = adapter_name
      end

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
                    default = vim.g.codecompanion_wataruu_model,
                  },
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = chat_adapter,
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

    vim.api.nvim_create_user_command("CCSetCopilotModel", function(opts)
      vim.g.codecompanion_copilot_model = opts.args
      if vim.g.codecompanion_chat_adapter == "copilot" then
        setup_codecompanion("copilot")
      end
      vim.notify("Copilot model: " .. vim.g.codecompanion_copilot_model)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("CCSetCodexModel", function(opts)
      vim.g.codecompanion_codex_model = opts.args
      if vim.g.codecompanion_chat_adapter == "codex" then
        setup_codecompanion("codex")
      end
      vim.notify("Codex model: " .. vim.g.codecompanion_codex_model)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("CCSetWataruuModel", function(opts)
      vim.g.codecompanion_wataruu_model = opts.args
      if vim.g.codecompanion_chat_adapter == "wataruu" then
        setup_codecompanion("wataruu")
      end
      vim.notify("Wataruu model: " .. vim.g.codecompanion_wataruu_model)
    end, { nargs = 1 })

    vim.api.nvim_create_user_command("CCShowAdapter", function()
      local model = ""
      if vim.g.codecompanion_chat_adapter == "copilot" then
        model = vim.g.codecompanion_copilot_model
      elseif vim.g.codecompanion_chat_adapter == "codex" then
        model = vim.g.codecompanion_codex_model
      elseif vim.g.codecompanion_chat_adapter == "wataruu" then
        model = vim.g.codecompanion_wataruu_model
      end
      vim.notify("Current CodeCompanion chat adapter: " .. tostring(vim.g.codecompanion_chat_adapter) .. " (model: " .. tostring(model) .. ")")
    end, {})
  '';
}
