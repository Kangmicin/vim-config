" =============== Required and Initial Settings ===============
" Use Vim settings rather than Vi settings. Must be first, it affects other options
set nocompatible

" Map the leader key. Must happen before Plug so all the settings can be set accordingly.
let mapleader = " "

" =============== Plug Initialization ===============
" This loads all the plugins specified in ~/.dotfiles/vim/plugs.vim
" Use Plug to manage all other plugins
if filereadable(expand("~/.vim/plugs.vim"))
  source ~/.vim/plugs.vim
endif

" ================ General ==========================

set history=1000                    " Store :cmdline history.
set showcmd                         " Show incomplete commands at the bottom
set showmode                        " Show current mode at the bottom
set ruler                           " Always show the current position
set backspace=indent,eol,start      " Allow backspace to delete everything
set autoread                        " Auto reload file when it's changed in the background
set showmatch                       " Show matching brackets and parentheses
syntax enable                       " Syntax highlighting
set encoding=utf-8                  " Force UTF-8 as standard encoding
set ffs=unix,dos,mac                " Unix as the standard file type
set laststatus=2                    " Always show the statusline
set number                          " Show line numbers
set guioptions-=r                   " Remove scrollbar for GUI Vim.
map q: :q
map :Q :q
map :W :w

" Key timeouts
set timeoutlen=250 ttimeoutlen=0

" The current buffer can be put to the background without writing to disk;
" When a background buffer becomes current again, marks and undo-history are remembered.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" move among buffers with CTRL
map <C-Right> :bnext<CR>
map <C-Left> :bprev<CR>

" ================ Dir specific vimrc ===============

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vimbackups > /dev/null 2>&1
  set undodir=~/.vimbackups
  set undofile
endif

" ================ Indentation ======================

set autoindent        " Automatically indent
set smartindent
set smarttab

" Set softtabs with 2 spaces
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" ================ Line Breaks ====================

" Don't wrap lines physically (auto insertion of newlines)
set nowrap "Don't wrap lines
set nolist " list disables linebreak
set textwidth=0 wrapmargin=0
set colorcolumn=80
set sidescroll=5
set listchars+=precedes:<,extends:>

" ================ Folds ============================

set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Don't fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                      " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~       " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip

" ================ Search =======================

set ignorecase
set smartcase
set incsearch       " Incremental search as you type
set hlsearch        " Highlight search results

" ================ Scrolling ========================

set scrolloff=20         "Start scrolling when we're 20 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Splits ========================

" on verrical
set splitbelow
" on horizontal
set splitright


" ================ Movement ========================
" ================ Copy and Paste ========================

let os = substitute(system('uname'), "\n", "", "")

" Yank text to the OS clipboard
if os == "Linux"
  noremap <leader>y "+y
  noremap <leader>Y "+Y
elseif os == "Darwin"
  noremap <leader>y "*y
  noremap <leader>Y "*Y
endif

" Preserve indentation while pasting text from the OS clipboard
if os == "Linux"
  noremap <leader>p :put +<CR>
elseif os == "Darwin"
  noremap <leader>p :put *<CR>
endif

" Jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Select text that was just pasted
noremap gV `[v`]

" Keep selection highlighted while shifting text
xnoremap <  <gv
xnoremap >  >gv

" ================ Custom Settings ========================
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
