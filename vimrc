"        1 IMPORTANT
"        2 MOVING AROUND, SEARCHING AND PATTERNS
"        3 TAGS
"        4 DISPLAYING TEXT
"        5 SYNTAX, HIGHLIGHTING AND SPELLING
"        6 BUFFERS, MULTIPLE WINDOWS
"        7 MULTIPLE TAB PAGES
"        8 TERMINAL
"        9 USING THE MOUSE
"       10 GUI
"       11 PRINTING
"       12 MESSAGES AND INFO
"       13 SELECTING TEXT
"       14 EDITING TEXT
"       15 TABS AND INDENTING
"       16 FOLDING
"       17 DIFF MODE
"       18 MAPPING
"       19 READING AND WRITING FILES
"       20 THE SWAP FILE
"       21 COMMAND LINE EDITING
"       22 EXECUTING EXTERNAL COMMANDS
"       23 RUNNING MAKE AND JUMPING TO ERRORS
"       24 SYSTEM SPECIFIC
"       25 LANGUAGE SPECIFIC
"       26 MULTI-BYTE CHARACTERS
"       27 VARIOUS
"       28 VIMRC SPECIFIC

" ------------------------------------------------------------------------
" IMPORTANT
" ------------------------------------------------------------------------
set nocompatible
let mapleader = ","

" Required for Vundle
filetype off

" Ensure proper runtime path based on filetypes (.vim or vimfiles)
if ( has('win16') || has('win32') || has('win64') )
    set rtp+=~/vimfiles/bundle/vundle
    call vundle#rc("$HOME/vimfiles/bundle")
else
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
endif

Bundle 'gmarik/vundle'

" ------------------------------------------------------------------------
" BUNDLES
" ------------------------------------------------------------------------

Bundle 'Tabular'
Bundle 'unimpaired.vim'
Bundle 'jellybeans.vim'

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

" ------------------------------------------------------------------------
" THE SWAP FILE
" ------------------------------------------------------------------------
set directory=.,$TEMP          " fix swap file temp issue on windows

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
" For some reason, working path doesn't default to $HOME on windows
if has("win32")
    cd $HOME
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
if has("autocmd")
    autocmd! BufWritePost _vimrc source $MYVIMRC    " auto-source on write
endif
