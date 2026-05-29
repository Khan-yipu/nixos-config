-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "6j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "6k", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>j", "J", { noremap = true, silent = true })
