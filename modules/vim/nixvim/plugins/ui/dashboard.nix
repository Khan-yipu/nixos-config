{
  programs.nixvim.extraConfigLua = ''
    local ok_dashboard, dashboard = pcall(require, "dashboard")
    if ok_dashboard then
      local image_path = vim.fn.expand("~/.nixconfigs/assets/asuka.jpg")
      local has_chafa = vim.fn.executable("chafa") == 1
      local has_image = vim.fn.filereadable(image_path) == 1
      local can_preview = has_chafa and has_image
      local fallback_header = {
        "",
        "######## ##   ##    ###    #######      ######   ###   ## ##  #######",
        "    ##   ##   ##   ## ##   ##    ##    ##      ## ##  ## ##  ##",
        "   ##    #######  ##   ##  ##    ##    ##     ##   ## ## ##  ####",
        "  ##     ##   ##  #######  ##    ##    ##     ####### ## ##  ##",
        "######## ##   ##  ##   ##  #######      ###### ##   ## ## ##  #######",
        "",
      }

      local header = fallback_header

      if can_preview then
        -- Keep a plain-text header for non-preview fallback paths.
        local chafa_cmd = string.format(
          "chafa -f symbols --symbols vhalf --size 72x18 --colors none %s 2>/dev/null",
          vim.fn.shellescape(image_path)
        )
        local rendered = vim.fn.systemlist(chafa_cmd)
        if vim.v.shell_error == 0 and rendered and #rendered > 0 then
          for i, line in ipairs(rendered) do
            -- Dashboard header is a normal buffer; strip terminal ANSI escapes.
            rendered[i] = line:gsub("\27%[[0-9;]*[A-Za-z]", "")
          end
          header = rendered
        end
      end

      local cfg = {
        theme = "hyper",
        config = {
          header = header,
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
          footer = { "Nixvim dashboard ready." },
        },
      }

      if can_preview then
        -- dashboard-nvim uses top-level preview options (not config.preview)
        cfg.preview = {
          command = "chafa -f symbols --symbols vhalf --size 72x18 --colors full --color-space rgb",
          file_path = image_path,
          file_width = 72,
          file_height = 18,
        }
      else
        cfg.config.footer = {
          "ZHAO CAKE",
          "Dashboard image unavailable (need chafa + assets/asuka.jpg).",
        }
      end

      dashboard.setup(cfg)
    end
  '';
}
