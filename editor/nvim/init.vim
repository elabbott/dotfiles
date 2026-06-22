" Neovim Configuration
" Place this file at: ~/.config/nvim/init.vim

set number
set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set cursorline
set termguicolors
set wrap
set linebreak
set nobackup
set noswapfile
set undofile
set undodir=~/.config/nvim/undo
set lazyredraw
set ttyfast

" Create undo directory if it doesn't exist
silent! call mkdir(&undodir, 'p')

" Leader key
let mapleader = "\<Space>"

" Key mappings
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>/ :nohlsearch<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split creation
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>

" Resize splits
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" File type specific settings
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType json setlocal tabstop=2 shiftwidth=2

" For Lua-based configuration, see init.lua
