" enable all features
set nocompatible

" initialize pathogen
call pathogen#infect()
call pathogen#helptags()

filetype on
filetype indent on
filetype plugin on

" ================ General Config ====================

set title                       "Set window title
set ttyfast                     "Send chracters more quickly
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=10000               "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

"$ Make Y behave like C and D
noremap Y y$

"Fix backspace
nnoremap <BS> dh


" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" always show statusbar
set laststatus=2

" Use poweline font for airline
let g:airline_powerline_fonts=1

" Configure theme
set background=light
colorscheme solarized
call togglebg#map("<F5>")

" Write with sudo command
cnoremap sudow w !sudo tee % >/dev/null

" ================ Window navigation ================
" Uses vim-tmux-navigator defaults on hjkl/
nnoremap <silent> <c-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <c-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <c-Right> :TmuxNavigateRight<cr>

" Also allow in interactive mode
inoremap <C-h>     <ESC><C-h>
inoremap <C-j>     <ESC><C-j>
inoremap <C-k>     <ESC><C-k>
inoremap <C-l>     <ESC><C-l>
inoremap <C-\>     <ESC><C-\>
inoremap <C-Left>  <ESC><C-h>
inoremap <C-Down>  <ESC><C-j>
inoremap <C-Up>    <ESC><C-k>
inoremap <C-Right> <ESC><C-l>

" tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>
nmap <S-Right> gt
nmap <S-Left> gT

" ================== Mouse enabled! =================
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    set ttymouse=xterm2
  endif
endif

" ================ Turn Off Swap Files ==============

"set swapfile
"set nobackup
"set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undoreload=10000
  set undolevels=10000
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
"Toggle word wrap
nnoremap <leader>w :set wrap!<cr>

nmap <C-i> msgg=G`s

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
nmap <silent> <C-c> :silent noh<CR>

" ================ Plugins ==========================
" Let syntastic use Puppet future parser
let g:syntastic_puppet_puppet_args = "--parser future"

" Nerdtree
nnoremap <leader>d :NERDTreeToggle<cr>
" Open nerdtree if no file loaded
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if only nerdtree is open on :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" tabular: align Puppet stanzas
nnoremap <leader>T :Tabularize /=><CR>

:nnoremap <C-w> :Bdelete<CR>

" CommandT: configure searcher
let g:CommandTFileScanner = 'git'
let g:CommandTInputDebounce = 20
