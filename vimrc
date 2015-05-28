" Author: 
"   Jonathan Ellington, heavy inspiration from https://github.com/amix/vimrc
" 
" Requires:
"   vim-plug plugin manager
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 
"
" Sections:
"   1. General
"   2. Plugins
"   3. User Interface
"   4. Colors, fonts
"   5. Text, tab, indent stuff
"   6. Moving around, tabs, buffers

" ------------------------------------------------------------------------
" General
" ------------------------------------------------------------------------

" Filetype plugins
filetype plugin on
filetype indent on 

" Swap mapleader and comma
let mapleader = ","

" Map space to colon, for convenience 
noremap <Space> :

" Keep 200 lines of command line history
set history=200                

" ------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-unimpaired'
Plug 'tComment'
Plug 'verilog_systemverilog.vim'
Plug 'git://github.com/altercation/vim-colors-solarized.git'
Plug 'ctrlp.vim'

call plug#end()

" ------------------------------------------------------------------------
" User Interface
" ------------------------------------------------------------------------

" Turn on wildmenu (enhanced command-line completion)
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win32") || has("win64")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
end

" Line numbers
set number

" Always show current position
set ruler

" Hidden buffers (can leave modified buffers)
set hidden

" Backspace over things it should backspace over
set backspace=indent,eol,start 

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Be smart about cases when searching
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros (for performance)
set lazyredraw

" Show matching brackets, parens, curlys
set showmatch

" Lines before scrolling with j/k
set scrolloff=4

" Shorter timeout for keycode sequences
set noerrorbells
set novisualbell
set timeoutlen=500


" ------------------------------------------------------------------------
" Colors and Fonts
" ------------------------------------------------------------------------

" Enable syntax highlighting
syntax enable

" Use a dark background
set background=dark

" Required for solarized to work
set term=xterm-256color

try
  colorscheme solarized
catch
endtry

" Extra GUI stuff
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
endif

" Use utf8 as standard encoding and en_us as standard language
set encoding=utf8
set spelllang=en_us

" ------------------------------------------------------------------------
" Text, tab, indent stuff
" ------------------------------------------------------------------------

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" Autoindent new lines, be smart about indenting
set autoindent
set smartindent

" Stop indents on shiftwidths (>,< cmds)
set shiftround                 

" Easy way to set tab spacing
nnoremap <leader>st :SetTabs<CR>
command! -nargs=* SetTabs call SetTabVals()
function! SetTabVals()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
endfunction

" ------------------------------------------------------------------------
" Moving around, tabs and buffers
" ------------------------------------------------------------------------

" Easily change to previously used buffer
nnoremap <Leader><Tab> <C-^>

" Place cursor anywhere
set virtualedit=all

" Easy way to turn off highlighting
map <silent> <leader><cr> :noh<cr>

" Easy way to move around windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Remember info about open buffers on close
set viminfo^=%

" Display incomplete commands in the status line
set showcmd

" Always show statusline
set laststatus=2

" Full filename in statusline
set statusline=%F              " full filename in statusline

" Easily edit vimrc file
nnoremap <silent> <leader>vw :e $MYVIMRC<CR>
nnoremap <silent> <leader>vt :tabedit $MYVIMRC<CR>

" Automatically source vimrc on write
if has ( "autocmd")
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC    " auto-source on write
endif

" ------------------------------------------------------------------------
" VERILOG ALIGNMENT
" ------------------------------------------------------------------------
vnoremap <leader>a/    :Tab /\/\/<CR>
vnoremap <leader>a<    :Tab /<=<CR>
nnoremap <leader>ai vi( :AlignInstance <CR>
nnoremap <leader>am vi( :AlignModule <CR>

command! -range AlignModule <line1>,<line2>call AlignVerilogModule()
function! AlignVerilogModule() range
  execute a:firstline . "," . a:lastline . 'GTabularize /^\s\+\w\+,\=\s\+\zs\/\/'
endfunction

command! -range AlignInstance <line1>,<line2>call AlignVerilogInstance()
function! AlignVerilogInstance() range
  execute a:firstline . "," . a:lastline . 'GTabularize /^[^(]*\zs('
  execute a:firstline . "," . a:lastline . 'GTabularize /^[^)]*\zs),\='
  execute a:firstline . "," . a:lastline . 'GTabularize /(.*)\zs\/\/'
endfunction
