" Author: 
"    Jonathan Ellington
" 
" Description: 
"    My vimrc file.  Should document better.
" 
" Mapping themes:

"   TABLE OF CONTENTS
"
"        1 IMPORTANT
"        2 BUNDLES
"        3 MOVING AROUND, SEARCHING AND PATTERNS
"        4 TAGS
"        5 DISPLAYING TEXT
"        6 SYNTAX, HIGHLIGHTING AND SPELLING
"        7 BUFFERS, MULTIPLE WINDOWS
"        8 MULTIPLE TAB PAGES
"        9 TERMINAL
"       10 USING THE MOUSE
"       11 GUI
"       12 PRINTING
"       13 MESSAGES AND INFO
"       14 SELECTING TEXT
"       15 EDITING TEXT
"       16 TABS AND INDENTING
"       17 FOLDING
"       18 DIFF MODE
"       19 MAPPING
"       20 READING AND WRITING FILES
"       21 THE SWAP FILE
"       22 COMMAND LINE EDITING
"       23 EXECUTING EXTERNAL COMMANDS
"       24 RUNNING MAKE AND JUMPING TO ERRORS
"       25 SYSTEM SPECIFIC
"       26 LANGUAGE SPECIFIC
"       27 MULTI-BYTE CHARACTERS
"       28 VARIOUS
"       29 VIMRC SPECIFIC

" ------------------------------------------------------------------------
" IMPORTANT
" ------------------------------------------------------------------------
set nocompatible

" Swap mapleader and comma
let mapleader = ","
noremap \ ,

" Required for Vundle
filetype off

" Ensure proper runtime path based on filetypes (.vim or vimfiles)
let vundleinstalled = 0
if ( isdirectory(expand("~/vimfiles/bundle/Vundle.vim")) )
  set rtp+=~/vimfiles/bundle/Vundle.vim
  call vundle#begin("$HOME/vimfiles/bundle")
  let vundleinstalled = 1
endif
if ( isdirectory(expand("~/.vim/bundle/Vundle.vim")) ) 
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  let vundleinstalled = 1
endif

let g:vundle_default_git_proto = 'git'

" ------------------------------------------------------------------------
" BUNDLES
" ------------------------------------------------------------------------

if (vundleinstalled)
  Plugin 'gmarik/Vundle.vim'
  Plugin 'godlygeek/tabular'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tComment'
  Plugin 'surround.vim'
  Plugin 'verilog_systemverilog.vim'
  Plugin 'tpope/vim-fugitive'

  Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'
  let g:tex_flavor='latex'
  let g:Tex_DefaultTargetFormat='pdf'

  Plugin 'ctrlp.vim'
  let g:ctrlp_max_files = 0

  call vundle#end()
endif

" ------------------------------------------------------------------------
" MOVING AROUND, SEARCHING AND PATTERNS
" ------------------------------------------------------------------------
set smartcase
set hls
nnoremap <C-l> <C-l>:nohls<CR>
nnoremap <leader>st :SetTabs<CR>
set tags=./tags;

" ------------------------------------------------------------------------
" TAGS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" DISPLAYING TEXT
" ------------------------------------------------------------------------
set number " line numbers, of course

" function for checking if a colorscheme exists (is in the rtp)
function! ColorschemeExists(color)
  return !empty(globpath(&rtp, 'colors/' . a:color . '.vim'))
endfunction

if ColorschemeExists('jellybeans')
  colorscheme jellybeans
elseif ColorschemeExists('desert')
  colorscheme desert
endif

" ------------------------------------------------------------------------
" SYNTAX, HIGHLIGHTING AND SPELLING
" ------------------------------------------------------------------------
filetype plugin indent on
syntax enable
set spelllang=en_us
set ve=all

" ------------------------------------------------------------------------
" BUFFERS & MULTIPLE WINDOWS
" ------------------------------------------------------------------------
set hidden                     " hidden buffers
nnoremap <Leader><Tab> <C-^>
nnoremap <Leader>b :CtrlPBuffer<CR>

" ------------------------------------------------------------------------
" MULTIPLE TAB PAGES
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" TERMINAL
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" USING THE MOUSE
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" GUI
" ------------------------------------------------------------------------
if has("gui_running")
  " Special list characters (EOL, tab..) highlighting
  highlight NonText guibg    = 'NONE'
  highlight NonText guifg    = #707070
  highlight SpecialKey guibg = 'NONE'
  highlight SpecialKey guifg = #707070

  set guioptions-=T
  if has("win32")
    set guifont=Consolas:h14:cANSI
  else
    set guifont=Luxi_Mono:h12:cANSI
  endif
endif

" ------------------------------------------------------------------------
" PRINTING
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" MESSAGES AND INFO
" ------------------------------------------------------------------------
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands in status line
set visualbell                 " use visual bell instead of alarm
set statusline+=%F             " full filename in statusline

" ------------------------------------------------------------------------
" SELECTING TEXT
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" EDITING TEXT
" ------------------------------------------------------------------------
set backspace=indent,eol,start " backspace over crap

" ------------------------------------------------------------------------
" TABS AND INDENTING
" ------------------------------------------------------------------------
set sr                         " stop indents on shiftwidths (>,< cmds)
set expandtab
set smarttab

let vimrc_tabstop=2
let &tabstop=vimrc_tabstop
let &shiftwidth=vimrc_tabstop
let &softtabstop=vimrc_tabstop

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
" FOLDING
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" DIFF MODE
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" MAPPING
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" READING AND WRITING FILES
" ------------------------------------------------------------------------

" Fixes overwriting symbolic links on windows
if ( has("win32") || has("win64") )
  set backupcopy=yes
endif

" ------------------------------------------------------------------------
" THE SWAP FILE
" ------------------------------------------------------------------------

if ( has("win32") || has("win64") )
  set directory=.,$TEMP          " fix swap file temp issue on windows
endif

" ------------------------------------------------------------------------
" COMMAND LINE EDITING
" ------------------------------------------------------------------------
noremap <Space> :
set history=200                " keep 200 lines of command line history

" ------------------------------------------------------------------------
" EXECUTING EXTERNAL COMMANDS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" RUNNING MAKE AND JUMPING TO ERRORS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" SYSTEM SPECIFIC
" ------------------------------------------------------------------------
if ( has('win32') || has('win64') )
  set shellslash
endif

" ------------------------------------------------------------------------
" LANGUAGE SPECIFIC
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" MULTI-BYTE CHARACTERS
" ------------------------------------------------------------------------

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif

  set encoding=utf-8           " better default than latin1
  setglobal fileencoding=utf-8 " file encoding for writing new files

  set listchars=tab:▸\ ,eol:¬  " cool characters for listing tabs & eol
endif

" ------------------------------------------------------------------------
" VARIOUS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" VIMRC SPECIFIC
" ------------------------------------------------------------------------
nnoremap <silent> <leader>vw :e $MYVIMRC<CR>
nnoremap <silent> <leader>vt :tabedit $MYVIMRC<CR>
if has ( "autocmd")
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC    " auto-source on write
endif


" ------------------------------------------------------------------------
" VERILOG ALIGNMENT
" ------------------------------------------------------------------------
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
