# Nixvim Module Guide

## Overview

This directory contains a fully modular Nixvim setup split by capability.

- `default.nix`: top-level Nixvim entry and module imports.
- `opts.nix`, `globals.nix`, `colorscheme.nix`: baseline editor behavior and theme defaults.
- `keymaps.nix`: unified keybinding layer.
- `TROUBLESHOOTING.md`: common failure patterns and recovery steps.
- `plugins/`: feature modules.
  - `ai/`: CodeCompanion, Copilot, render-markdown.
  - `lsp/`: native LSP (Neovim 0.11 API), split into `shared.nix` and `servers/`.
  - `completion/`: cmp + snippets.
  - `navigation/`: Telescope, Neo-tree, Trouble.
  - `editing/`: autopairs, comments, surround.
  - `quality/`: treesitter, formatting, lint, gitsigns.
  - `ui/`: Noice, Notify, Dressing, Flash, Snacks, extra themes.

## Feature Matrix

- LSP
  - Native `vim.lsp.config` + `vim.lsp.enable` pipeline.
  - Shared capabilities and per-server modular setup.
  - Servers configured: `clangd`, `rust_analyzer`, `hls`, `verible`, `metals`.
- Completion
  - `nvim-cmp` + `cmp-nvim-lsp` + `luasnip` + `friendly-snippets`.
- Navigation
  - Telescope find/grep/buffers/recent.
  - Neo-tree explorer.
  - Trouble diagnostics panel.
- UI
  - Noice commandline popup, markdown rendering override, and message routing.
  - Notify as the default notification backend.
  - Dressing for improved input/select prompts.
  - Flash for fast in-buffer jumps.
  - Snacks utility modules (input/notifier/picker/quickfile/statuscolumn/words).
- AI
  - CodeCompanion using Copilot adapter.
  - Render Markdown support for markdown and codecompanion buffers.

## Keymap Cheatsheet

Leader key is space.

- `a` AI
  - `<leader>aa`: CodeCompanion actions.
  - `<leader>ac`: CodeCompanion chat.
  - `<leader>a1`: switch chat adapter to Copilot.
  - `<leader>a2`: switch chat adapter to Codex.
  - `<leader>a3`: switch chat adapter to Wataruu API.
  - `<leader>as`: show current chat adapter.
- `e` Explorer
  - `<leader>e`: toggle Neo-tree.
- `f` Find
  - `<leader>ff`: files.
  - `<leader>fg`: live grep.
  - `<leader>fb`: buffers.
  - `<leader>fr`: recent files.
- `l` LSP
  - `gd`, `gD`, `gi`, `gr`, `K`: go-to and hover actions.
  - `<leader>lr`: rename.
  - `<leader>la`: code action.
  - `<leader>ld`: buffer diagnostics via Telescope.
  - `<leader>lf`: format with Conform.
- `n` Notify / Noice
  - `<leader>nn`: Noice history.
  - `<leader>nl`: Noice last message.
  - `<leader>nd`: Noice dismiss.
- `u` UI
  - `<leader>ux`: open Noice.
  - `<leader>us`: Snacks file picker.
  - `<leader>ud`: open Dashboard.
- `t` Theme
  - `<leader>tf`: everforest.
  - `<leader>tc`: catppuccin.
  - `<leader>tt`: tokyonight.
  - `<leader>tk`: kanagawa.
  - `<leader>tg`: gruvbox.
- `x` Problems
  - `<leader>xx`: Trouble diagnostics toggle.
- Motion
  - `s`: Flash jump.
  - `S`: Flash treesitter jump.

## Theme Switching

Startup theme is randomly selected from:

- `everforest`
- `catppuccin`
- `tokyonight`
- `kanagawa`
- `gruvbox`

If random selection fails for any reason, fallback is `everforest` (`background = "medium"`).

Switch at runtime:

- `:colorscheme everforest`
- `:colorscheme catppuccin`
- `:colorscheme tokyonight`
- `:colorscheme kanagawa`
- `:colorscheme gruvbox`

Fast switch keymaps:

- `<leader>tf`, `<leader>tc`, `<leader>tt`, `<leader>tk`, `<leader>tg`

## CodeCompanion Markdown Rendering

CodeCompanion is paired with `render-markdown-nvim` to improve markdown display for AI responses. The renderer is initialized with:

- `file_types = { "markdown", "codecompanion" }`

## CodeCompanion Adapter Switching

This setup supports three chat adapters:

- `copilot`
- `codex`
- `wataruu` (`https://api.wataruu.me/v1`)

Default models:

- copilot: `gpt-4.1`
- codex: `gpt-5.3-codex`
- wataruu: `gpt-5.4`

Switch methods:

- Keymaps: `<leader>a1`, `<leader>a2`, `<leader>a3`
- Commands: `:CCUseCopilot`, `:CCUseCodex`, `:CCUseWataruu`
- Query current adapter: `<leader>as` or `:CCShowAdapter`

Model switching methods:

- `:CCSetCopilotModel <model>`
- `:CCSetCodexModel <model>`
- `:CCSetWataruuModel <model>`

Chat window layout/sizing methods:

- `:CCSetChatWidthCols <cols>`: use fixed right-side column width.
- `:CCSetChatWidthRatio <0-1>`: use right-side width ratio (switches off fixed cols).

Examples:

- `:CCSetWataruuModel gpt-4o`
- `:CCSetWataruuModel gpt-4o-mini`
- `:CCSetWataruuModel gpt-5.4`
- `:CCSetCodexModel gpt-5.3-codex`

Layout defaults:

- Chat window layout: `vertical`
- Chat window position: `right`
- Width strategy: fixed cols first (`58`), else ratio (`0.38`)

## Dashboard

Dashboard is enabled with image preview using:

- plugin: `dashboard-nvim`
- renderer: `chafa`
- image: `~/.nixconfigs/assets/asuka.jpg`

Rendering strategy:

- Color mode uses dashboard's top-level `preview` with:
  - `chafa -f symbols --symbols vhalf --size 72x18 --colors full`
- This is rendered inside dashboard's terminal preview window (`termopen`).
- Fallback mode renders plain text into `header` if preview prerequisites are missing.

Fallback behavior:

- If rendering fails or prerequisites are missing, a chunky ASCII `ZHAO CAKE` banner is shown.
- Dashboard still loads normally with a fallback footer message.

Why some setups look different:

- Many showcased Neovim dashboards are not `dashboard-nvim`; common alternatives are `alpha-nvim`, `snacks.dashboard`, or setups with `image.nvim`.
- `dashboard-nvim` currently does not ship a first-class graphics-protocol pipeline (kitty/sixel/ueberzug) and depends on terminal preview behavior.

Open dashboard:

- `:Dashboard`
- `<leader>ud`

Note:

- Inline and cmd interactions stay on Copilot for stability.
- Chat interaction follows the selected adapter.

Security recommendation:

- `WATARUU_API_KEY` is currently configured via Home Manager session variables.
- For safer secret handling, move it to a private secrets manager and inject through env at login.

## Next Plugins To Consider

- `mini.nvim`
  - High-quality modular UX toolkit (pairs, ai textobjects, files, statusline).
- `todo-comments.nvim`
  - Makes TODO/FIXME style comments first-class searchable diagnostics.
- `oil.nvim`
  - Buffer-native file management alternative to tree explorers.
- `lazygit.nvim`
  - Embedded Git TUI inside Neovim workflows.
- `persistence.nvim`
  - Session restore with minimal friction after restart.
- `fidget.nvim`
  - Lightweight LSP progress and task feedback.
- `twilight.nvim` + `zen-mode.nvim`
  - Focus mode for writing/review sessions.
- `inc-rename.nvim`
  - Better rename UX with preview-style commandline updates.
