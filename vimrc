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
let mapleader = ","

" Required for Vundle
filetype off

" Ensure proper runtime path based on filetypes (.vim or vimfiles)
let vundleinstalled = 0
if ( isdirectory(expand("~/vimfiles/bundle/vundle")) )
    set rtp+=~/vimfiles/bundle/vundle
    call vundle#rc("$HOME/vimfiles/bundle")
    let vundleinstalled = 1
endif
if ( isdirectory(expand("~/.vim/bundle/vundle")) ) 
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
    let vundleinstalled = 1
endif

" ------------------------------------------------------------------------
" BUNDLES
" ------------------------------------------------------------------------

if (vundleinstalled)
    Bundle 'gmarik/vundle'
    Bundle 'Tabular'
    Bundle 'unimpaired.vim'
    Bundle 'jellybeans.vim'
    Bundle 'surround.vim'
endif

" ------------------------------------------------------------------------
" MOVING AROUND, SEARCHING AND PATTERNS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" TAGS
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" DISPLAYING TEXT
" ------------------------------------------------------------------------
nnoremap <silent> <leader>tl :set list!<CR>
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
nnoremap <silent> <leader>ts :set spell!<CR>
nnoremap <silent> <leader>th :set hlsearch!<CR>
syntax enable
set spelllang=en_us

" ------------------------------------------------------------------------
" BUFFERS & MULTIPLE WINDOWS
" ------------------------------------------------------------------------
set hidden                     " hidden buffers
nnoremap <Leader><Tab> <C-^>

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
    set guifont=Consolas:h11
    highlight NonText guibg    = 'NONE'
    highlight NonText guifg    = #707070
    highlight SpecialKey guibg = 'NONE'
    highlight SpecialKey guifg = #707070
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

" ------------------------------------------------------------------------
" SELECTING TEXT
" ------------------------------------------------------------------------

" ------------------------------------------------------------------------
" EDITING TEXT
" ------------------------------------------------------------------------
set backspace=indent,eol,start " backspace over crap
nnoremap <Enter> o<Esc>
nnoremap <S-Enter> O<Esc>

" ------------------------------------------------------------------------
" TABS AND INDENTING
" ------------------------------------------------------------------------
set sr                         " stop indents on shiftwidths (>,< cmds)
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

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
if ( has("win32") )
    set backupcopy=yes
endif

" ------------------------------------------------------------------------
" THE SWAP FILE
" ------------------------------------------------------------------------

if ( has("win32") )
    set directory=.,$TEMP          " fix swap file temp issue on windows
endif

" ------------------------------------------------------------------------
" COMMAND LINE EDITING
" ------------------------------------------------------------------------
nnoremap <Space> :
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
if has("autocmd")
    autocmd! BufWritePost $MYVIMRC source $MYVIMRC    " auto-source on write
endif
