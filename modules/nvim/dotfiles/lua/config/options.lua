-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Tab 和缩进设置
vim.o.tabstop = 2 -- Tab 显示为2个空格
vim.o.shiftwidth = 2 -- 自动缩进使用2个空格
vim.o.expandtab = true -- Tab 转换为空格
vim.o.softtabstop = 2 -- 编辑时按 Tab 插入2个空格
-- vim.o.autoindent = true -- 自动缩进
vim.o.smartindent = true -- 自动缩进
vim.o.cindent = true -- C 风格缩进
