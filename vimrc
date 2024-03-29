" enable all features
set nocompatible
set timeout timeoutlen=1000 ttimeoutlen=100

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
set switchbuf=useopen,usetab    "Switch to already opened files

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
if $ITERM_PROFILE =~ 'Dark' || $VIM_PROFILE =~ 'Dark'
  set background=dark
else
  set background=light
endif


" Enable true colors if available
set termguicolors
" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic

colorscheme solarized
highlight Comment cterm=italic gui=italic
call togglebg#map("<F5>")

" Write with sudo command
cnoremap sudow w !sudo tee % >/dev/null

" ================ Window navigation ================
nnoremap <C-Left>  <C-W><C-H>
nnoremap <C-Down>  <C-W><C-J>
nnoremap <C-Up>    <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>

set splitbelow
set splitright

" ================= Buffers & tabs ====================
let g:airline#extensions#bufferline#enabled=0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
noremap <C-t> :enew<cr>

" Move to the next buffer
noremap <C-S-Right> :bnext<cr>

" Move to the previous buffer
noremap <C-S-Left> :bprevious<cr>

" Close buffer
nnoremap <C-w> :Bdelete<CR>

" ================== Mouse enabled! =================
if has('mouse') && !has('nvim')
  set mouse=a
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
endif

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
" set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
"set showbreak=↪\
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

"Toggle word wrap
nnoremap <leader>w :set wrap!<cr>

" tab? to reindent?
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

" ================ Scrolling ========================

" set scrolloff=8         "Start scrolling when we're 8 lines away from margins
" set sidescrolloff=15
" set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
nmap <silent> <C-c> :silent noh<CR>

" ================ Plugins ==========================
" Disable whitespace checks in airline
let g:airline#extensions#whitespace#enabled = 0

" Nerdtree
nnoremap <leader>d :NERDTreeToggle<cr>
" Open nerdtree if no file loaded
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if only nerdtree is open on :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
