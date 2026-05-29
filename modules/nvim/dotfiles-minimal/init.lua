-- ~/.config/nvim/init.lua
-- 基础设置
-- vim.o.clipboard = "unnamedplus"           -- 与系统剪贴板共享
vim.opt.clipboard = "unnamedplus" -- 使用系统剪贴板
vim.o.compatible = false -- 禁用 vi 兼容模式
vim.o.scrolloff = 5 -- 上下滚动时保留5行可见
vim.o.wildmenu = true -- 命令行补全
vim.o.showcmd = true -- 显示命令
vim.o.hlsearch = true -- 高亮搜索结果
vim.o.incsearch = true -- 实时搜索
vim.o.mouse = "a" -- 启用鼠标
vim.o.number = true -- 显示行号
vim.o.relativenumber = false -- 不显示相对行号
vim.o.ignorecase = true -- 搜索忽略大小写
vim.o.smartcase = true -- 智能大小写
vim.o.laststatus = 2 -- 总是显示状态栏
vim.o.autochdir = true -- 自动切换当前目录
-- 怎么回事
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- 主编辑区背景透明
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- 浮动窗口（如 LSP 提示）背景透明
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- 终端设置
vim.o.termguicolors = true -- 启用真彩色
vim.opt.termguicolors = true -- 另一种设置方式
-- vim.o.t_ut = ""                           -- 终端背景色

-- Tab 和缩进设置
vim.o.tabstop = 4 -- Tab 显示为2个空格
vim.o.shiftwidth = 4 -- 自动缩进使用2个空格
vim.o.expandtab = true -- Tab 转换为空格
vim.o.softtabstop = 4 -- 编辑时按 Tab 插入2个空格
vim.o.autoindent = true -- 自动缩进
vim.o.cindent = true -- C 风格缩进

-- 语法和文件类型
vim.cmd("syntax on") -- 语法高亮
vim.cmd("filetype on") -- 启用文件类型检测
vim.o.cursorline = true -- 高亮当前行

-- 清除搜索高亮
vim.cmd("nohlsearch")

-- 设置 Leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 自动命令：恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})

-- 键位映射
local function setup_mappings()
	local opts = { noremap = true, silent = true }
	local expr_opts = { noremap = true, silent = true, expr = false }

	-- 清除搜索高亮
	vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", opts)

	-- 快速移动
	vim.keymap.set("n", "J", "6j", opts)
	vim.keymap.set("n", "K", "6k", opts)
	vim.keymap.set("i", "jk", "<Esc>", opts)
	vim.keymap.set("n", "<leader>j", "J", opts)

	-- 跳转时居中显示
	vim.keymap.set("n", "n", "nzz", opts)
	vim.keymap.set("n", "N", "Nzz", opts)

	-- 窗口分割
	vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", opts)
	-- vim.keymap.set("n", "<leader>rc", ":tabe ~/.config/nvim/init.lua<CR>", opts)
	vim.keymap.set("n", "<leader>vl", ":set splitright<CR>:vsplit<CR>", opts)
	vim.keymap.set("n", "<leader>vh", ":set nosplitright<CR>:vsplit<CR>", opts)
	vim.keymap.set("n", "<leader>hk", ":set nosplitbelow<CR>:split<CR>", opts)
	vim.keymap.set("n", "<leader>hj", ":set splitbelow<CR>:split<CR>", opts)

	-- 窗口导航
	vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
	vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
	vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
	vim.keymap.set("n", "<C-k>", "<C-w>k", opts)

	-- Tab 管理
	vim.keymap.set("n", "tt", ":tabe<CR>", opts)
	vim.keymap.set("n", "H", ":-tabnext<CR>", opts)
	vim.keymap.set("n", "L", ":+tabnext<CR>", opts)

	-- 保存文件
	vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

	-- 自动补全括号
	vim.keymap.set("i", "(", "()<Esc>i", opts)
	vim.keymap.set("i", "[", "[]<Esc>i", opts)
	vim.keymap.set("i", "{", "{}<Esc>i", opts)
	vim.keymap.set("i", "'", "''<Esc>i", opts)
	vim.keymap.set("i", '"', '""<Esc>i', opts)

	-- 重新加载配置
	-- vim.keymap.set("n", "R", ":source $MYVIMRC<CR>", opts)
end

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
			"cd %s && gcc %s -o %s && time ./%s",
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

-- 设置按键映射
vim.keymap.set("n", "<f5>", compile_run_gcc, { noremap = true, silent = true })
-- ===================================================

-- C语言特定配置
local function setup_c_lang()
	-- 插入模板函数
	local function insert_ctemplate()
		vim.cmd("0r ~/.config/nvim/Ctemplate.c")
		vim.cmd("normal! 6j")
		vim.cmd("startinsert!")
	end

	-- 设置快捷键
	vim.keymap.set("n", "mf", insert_ctemplate, { buffer = 0, desc = "Insert C template" })

	-- C语言括号自动补全
	vim.keymap.set("i", "{", "{<CR>}<Esc>O", { buffer = 0 })
end

-- 为C文件设置自动命令
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = setup_c_lang,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = setup_c_lang,
})

-- 光标样式设置
-- vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave" }, {
-- 	callback = function()
-- 		vim.cmd([[silent !echo -ne "\e[2 q"]])
-- 		vim.cmd("redraw!")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertChange" }, {
-- 	callback = function()
-- 		local insert_mode = vim.api.nvim_get_mode().mode
-- 		if insert_mode == "i" then
-- 			vim.cmd([[silent !echo -ne "\e[6 q"]])
-- 			vim.cmd("redraw!")
-- 		elseif insert_mode == "r" or insert_mode == "v" or insert_mode == "\22" then
-- 			vim.cmd([[silent !echo -ne "\e[4 q"]])
-- 			vim.cmd("redraw!")
-- 		end
-- 	end,
-- })
-- 
-- vim.api.nvim_create_autocmd("VimLeave", {
-- 	callback = function()
-- 		vim.cmd([[silent !echo -ne "\e[ q"]])
-- 		vim.cmd("redraw!")
-- 	end,
-- })

-- 加载 Markdown 代码片段
local function load_markdown_snippets()
	local snippet_path = "~/.config/nvim/snippits.vim"
	local file = io.open(snippet_path, "r")
	if file then
		file:close()
		vim.cmd("source " .. snippet_path)
	else
		vim.notify("Markdown snippets file not found: " .. snippet_path, vim.log.levels.WARN)
	end
end

-- 为 Markdown 文件设置自动命令
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = load_markdown_snippets,
})

-- 初始化
setup_mappings()

-- 打印加载完成信息
--vim.defer_fn(function()
--  vim.notify("Neovim configuration loaded successfully!", vim.log.levels.INFO)
--end, 100)

-- 检查是否在 Neovide 环境中运行
if vim.g.neovide then
  -- 1. 设置字体 (也可以用环境变量，写在 lua 里更集中)
  -- vim.o.guifont = "JetBrainsMono Nerd Font:h14:b"
  vim.o.guifont = "Iosevka:h14:b"

  -- 2. 字体渲染提示 (解决某些字体发虚的问题)
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5

  -- 3. 主题与透明度
  -- vim.g.neovide_transparency = 0.9           -- 窗口透明度 (0.0 - 1.0) old version of neovide 
  -- new version use neovide_opacity
  vim.g.neovide_opacity= 0.8
  vim.g.neovide_window_floating_blur_amount_x = 2.0
  vim.g.neovide_window_floating_blur_amount_y = 2.0

  -- 4. 鼠标设置 (Neovide 自带鼠标支持，建议不要在 nvim 里再隐藏)
  -- vim.opt.mouse = ""

  -- 5. Neovide 专属快捷键配置
  -- Ctrl+F11 切换全屏
  vim.keymap.set('n', '<C-F11>', function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end)
  
  -- Ctrl+加号/减号 调整字体大小
  vim.keymap.set('n', '<C-+>', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end)
  vim.keymap.set('n', '<C-->', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end)
  vim.keymap.set('n', '<C-0>', function() vim.g.neovide_scale_factor = 1.0 end)

  -- 6. 粘贴图片功能 (需要配合特定插件，如 hoob3rt/lualine.nvim 或 snaking-paste)
  vim.g.neovide_input_use_logo = 1 -- 允许在 macOS 上使用 Cmd 键
end
