set clipboard=unnamedplus
" set clipboard=unnamed
set nocompatible
set scrolloff=5
" set wrap 
set wildmenu
set showcmd

let &t_ut=''
set hlsearch
exec "nohlsearch"
set incsearch
set mouse=a
set number
""set relativenumber
set ignorecase
set smartcase
set laststatus=2
set autochdir

noremap n nzz
noremap N Nzz

" 显示光标行横线
" set cursorline
 
" 高亮打开
syntax on

" 打开文件检测
filetype on

" 设置 tab 键的宽度为 4 个空格
set tabstop=4
 
" 设置当输入 tab 时，实际插入的空格数为 4
set shiftwidth=4

" 将 tab 转换为空格
set expandtab
    
" （可选）设置自动缩进时使用空格而不是 tab
" set softtabstop=4
 
" 设置自动缩进
" set autoindent

" 设置使用 c/c++ 语言的自动缩进方式
" set cindent

" leader space
let mapleader = " "

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" |   endif

noremap <leader><CR> :nohlsearch<CR>

"" fast move the cursor and view the file 
nnoremap J 6j
nnoremap K 6k
inoremap jk <Esc>
nnoremap <leader>j J

"" Split window and move cursor
map <leader>rc :e ~/.vimrc<CR>
map <leader>vl :set splitright<CR>:vsplit<CR>
map <leader>vh :set nosplitright<CR>:vsplit<CR>
map <leader>hk :set nosplitbelow<CR>:split<CR>
map <leader>hj :set splitbelow<CR>:split<CR>
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map tt :tabe<CR> 
map H :-tabnext<CR>
map L :+tabnext<CR>
"map sj <C-w>t<C-w>K
"map sl <C-w>t<C-w>H

" 括号
" inoremap < <><Esc>i
""inoremap { {<CR>}<Esc>O
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
""inoremap ,[ {}<Esc>i
inoremap { {}<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

""save file using Ctrl-s
""nnoremap <leader>s :w<CR>
inoremap <C-s> <Esc>:w<CR>a

"" c语言
""===========================
""
autocmd Filetype c nnoremap mf :0r /home/khanif/Desktop/code/language/c/Ctemplate.c<CR>5j:startinsert!<CR><CR>
autocmd Filetype c inoremap { {<CR>}<Esc>O
 

" 光标
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"" Markdown snippits
source /home/khanif/Desktop/code/useful/vimconf/snippits.vim

" Compile function
map <leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    silent! exec "!clear"
    exec "!time python3 %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'vimwiki'
    exec "MarkdownPreview"
  endif
endfunc

"map R :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
"  exec "w"
"  if &filetype == 'vim'
"    exec "source $MYVIMRC"
"  elseif &filetype == 'markdown'
"    exec "echo"
"  endif
"endfunc

nnoremap R :source $MYVIMRC<CR>
