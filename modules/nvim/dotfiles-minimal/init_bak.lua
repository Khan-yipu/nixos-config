-- leader = space
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "J", "6j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "6k", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>j", "J", { noremap = true, silent = true })

vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- 主编辑区背景透明
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- 浮动窗口（如 LSP 提示）背景透明
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.opt.termguicolors = true -- 启用真彩色

-- ===================================================
-- init.lua compile and run
local function compile_run_gcc()
	vim.cmd("write") -- 保存当前文件

	local ft = vim.bo.filetype -- 获取文件类型

	local file_path = vim.fn.expand("%:p")
	local file_name = vim.fn.expand("%:t:r")
	local file_dir = vim.fn.expand("%:p:h")
	-- 使用 if-elseif 链处理不同文件类型
	--if ft == "c" then
	--  vim.cmd("set splitbelow")
	--  vim.cmd("sp")
	--  vim.cmd("resize -5")
	--    vim.cmd("term gcc % -o %< && time ./%<")
	if ft == "c" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("resize +5")

		local file_path = vim.fn.expand("%:p")
		local file_name = vim.fn.expand("%:t:r")
		local file_dir = vim.fn.expand("%:p:h")

		local command = string.format(
			-- "cd %s && gcc %s -o %s && time ./%s",
			"cd %s && gcc %s -o %s -lm && time ./%s",
			vim.fn.shellescape(file_dir),
			vim.fn.shellescape(file_path),
			vim.fn.shellescape(file_name),
			vim.fn.shellescape(file_name)
		)

		vim.cmd("term " .. command)
	elseif ft == "cpp" then
		vim.cmd("set splitbelow")
		vim.cmd("!g++ -std=c++11 % -Wall -o %<")
		vim.cmd("sp")
		vim.cmd("resize -15")
		vim.cmd("term ./%<")
	elseif ft == "cs" then
		vim.cmd("set splitbelow")
		vim.cmd("silent !mcs %")
		vim.cmd("sp")
		vim.cmd("resize -5")
		vim.cmd("term mono %<.exe")
	elseif ft == "java" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("resize -5")
		vim.cmd("term javac % && time java %<")
	elseif ft == "rust" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("resize -5")
		-- vim.cmd("term cargo build && cargo run")
		vim.cmd("term cargo run")
	elseif ft == "sh" then
		vim.cmd("term time bash %")
	elseif ft == "python" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("term python3 %")
	elseif ft == "html" then
		vim.cmd("silent !" .. vim.g.mkdp_browser .. " % &")
	elseif ft == "markdown" then
		vim.cmd("InstantMarkdownPreview")
	elseif ft == "tex" then
		vim.cmd("silent VimtexStop")
		vim.cmd("silent VimtexCompile")
	elseif ft == "dart" then
		vim.cmd("CocCommand flutter.run -d " .. vim.g.flutter_default_device .. " " .. vim.g.flutter_run_args)
		vim.cmd("silent CocCommand flutter.dev.openDevLog")
	elseif ft == "javascript" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd('term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .')
	elseif ft == "racket" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("resize -5")
		vim.cmd("term racket %")
	elseif ft == "go" then
		vim.cmd("set splitbelow")
		vim.cmd("sp")
		vim.cmd("term go run .")
	end
end
-- ===================================================

-- 设置按键映射
vim.keymap.set("n", "<f5>", compile_run_gcc, { noremap = true, silent = true })

-- 启用相对行号
vim.wo.number = true -- 显示绝对行号
-- vim.wo.relativenumber = true -- 显示相对行号

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- vim.cmd("source ~/.config/nvim/auto_compile.vim")
--
-- vim.opts.rocks.hererocks = false
-- vim.opts.rocks.enabled = false

-- 定义函数
local function insert_ctemplate()
	-- 读取模板文件到第0行（开头）
	vim.cmd("0r ~/.config/nvim/Ctemplate.c")
	-- 向下移动5行
	vim.cmd("normal! 6j")
	-- 进入插入模式
	vim.cmd("startinsert!")
end

-- 为C文件设置快捷键
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		-- 设置快捷键，使用mf插入C模板
		vim.keymap.set("n", "mf", insert_ctemplate, {
			buffer = 0, -- 仅在当前缓冲区生效
			desc = "Insert C template",
		})
	end,
})
