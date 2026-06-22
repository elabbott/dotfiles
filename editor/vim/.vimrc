" Vim Configuration

" Enable syntax highlighting
syntax on

" Use 24-bit color
set termguicolors

" Line numbers
set number
set relativenumber

" Tabs and indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Appearance
set cursorline
set colorcolumn=80,120
set wrap
set linebreak

" Backups and swaps
set nobackup
set noswapfile
set undofile
set undodir=~/.vim/undo
silent! call mkdir(&undodir, 'p')

" Performance
set lazyredraw
set ttyfast

" Key mappings
let mapleader = "\<Space>"

" Quick save
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Navigation
nnoremap <leader>h :split<CR>
nnoremap <leader>v :vsplit<CR>

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Disable arrow keys (optional, for learning)
" nnoremap <Up> <NOP>
" nnoremap <Down> <NOP>
" nnoremap <Left> <NOP>
" nnoremap <Right> <NOP>
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>
" inoremap <Left> <NOP>
" inoremap <Right> <NOP>

" Auto commands
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown setlocal spell spelllang=en_us

" File type specific settings
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType json setlocal tabstop=2 shiftwidth=2

" Plugin configuration (if using vim-plug or similar)
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
