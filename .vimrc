""""""""""""""""""""""""""""""""     vimrc     """"""""""""""""""""""""""""""{{{
set nocompatible              " be iMproved, required
set encoding=utf-8
"}}}

"""""""""""""""""""""""""""""""     vim-plug     """"""""""""""""""""""""""""{{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"""""""""""""""""""""""""""""""     Plugins     """"""""""""""""""""""""""""""""{{{
call plug#begin('~/.vim/plugged')

" Can't imagine Vim without these
Plug 'tpope/vim-surround'             " Affect your surroundings. Example: ds'
Plug 'tpope/vim-sensible'             " Fix the stupid things left from Vi
Plug 'tpope/vim-repeat'               " Make . repeat (some) plugin actions
Plug 'tpope/vim-speeddating'          " <c-a> and <c-x> correct with iso dates
Plug 'tpope/vim-commentary'           " Toggle comments
Plug 'junegunn/vim-easy-align'        " Align on a character: `gaip&`

" TPopes corner:
Plug 'tpope/vim-endwise'              " Autocomplete if ... endif
Plug 'tpope/vim-abolish'              " Change words better

" Syntax highligting
Plug 'mephux/bro.vim'                 " For bro scripts
Plug 'chikamichi/mediawiki.vim'       " Syntax highlighting for MediaWiki-based projects

" Writing
Plug 'godlygeek/tabular'              " Good at aligning on multiple chars at once: `:Tab /&`

" Beta:
Plug 'jpalardy/vim-slime'
Plug 'airblade/vim-gitgutter'         " Shows git diff (+/-) in the gutter
Plug 'wellle/targets.vim'             " Add more text objects to work on
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/searchfold.vim'     " fold lines not in /
Plug 'fatih/vim-go'                   " golang
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Looks
Plug 'junegunn/goyo.vim'              " Distraction-free writing in Vim
Plug 'flazz/vim-colorschemes'         " All the colorschemes

" Do I use these?
Plug 'LaTeX-Box-Team/LaTeX-Box'       " LaTeX tools
Plug 'haya14busa/incsearch.vim'       " Improved hlsearch

call plug#end()
"}}}

"""""""""""""""""""""""""""     Usability fixes     """"""""""""""""""""""""""""{{{

" Disbale command-line menu (see `:h q:`)
noremap q: <Nop>
noremap q/ <Nop>
noremap q? <Nop>
cmap <C-f> <Nop>

" Use global undo history
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

"}}}

"""""""""""""""""""""""""""""""     Movement     """"""""""""""""""""""""""""""""{{{

""jklö
noremap l h
noremap ö l

" Make vertical movement work with wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" set langmap=öV might fix something...
" To move between panes without pain
" map <c-l> <C-W><C-H>
" map <c-j> <C-W><C-J>
" map <c-k> <C-W><C-K>
" map <c-ö> <C-W><C-L>
" set langmap=öö

"}}}

""""""""""""""""""""""""""""""     Interface     """""""""""""""""""""""""""""""{{{
set ignorecase
set smartcase
set number
set splitbelow
set splitright
set list
set hlsearch
syntax spell toplevel
set showmatch
set sidescroll=1
set sidescrolloff=0

set nospell
set spelllang=en

"}}}

"""""""""""""""""""""""""""""""     Vainity     """"""""""""""""""""""""""""""""{{{

set background=dark

set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=Black
hi CursorColumn cterm=NONE ctermbg=Black

" Change of Spell* behave
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=red
hi clear SpellCap
hi SpellCap cterm=underline,bold ctermfg=blue

" Highlight the n'th column (depending on &textwidth) and also column 100+
highlight ColorColumn ctermbg=NONE ctermfg=Red
let &colorcolumn="+1,+".join(range(20,999), ",+")

highlight Normal ctermfg=white ctermbg=NONE
highlight Todo ctermfg=white ctermbg=NONE

set foldmethod=marker

"}}}

""""""""""""""""""""""""""""""     Text style     """""""""""""""""""""""""""""""{{{
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set textwidth=80
set linebreak
set nowrap
set wrapmargin=0 " Prevent vim from automatically inserting line breaks in newly entered text.

"}}}

"""""""""""""""""""""""""""""""     Mappings     """"""""""""""""""""""""""""""""{{{

" Leader mapping
let mapleader = ','

noremap <space> :
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>

nnoremap <C-t> :tabedit<Space>

nnoremap gf :tabedit <cfile><CR>

nnoremap Y y$

" Quicklings
cnoremap qq q!
cab spg spellgood
map <leader>q gqap
map <leader>b 0"qd$

" Clear hlsearch
nnoremap <silent> <c-l> :noh<CR>
inoremap <silent> <c-l> <esc>:noh<CR>a

"""" Macros
nnoremap <leader><leader> @q
nnoremap <enter> @@

" Spell
map hh zG

"}}}

"""""""""""""""""""""""""     Prerecorded macros:     """"""""""""""""""""""""""{{{

" Put sentence on its own line and reformat it
let @s='disOPgqis<<'
nnoremap <leader>s @s

"}}}

""""""""""""""""""""""""""""     Function calls     """""""""""""""""""""""""""""{{{

" Press <F5> to insert timestamp YYYY-MM-DD_HH:MM:SS
nnoremap h<F5> "=strftime("%F_%T")<CR>P
nnoremap <F5> "=strftime("%F")<CR>P
inoremap h<F5> <C-R>=strftime("%F_%T")<CR>
inoremap <F5> <C-R>=strftime("%F")<CR>

" <F6> to remove trailing whitespace
nnoremap <silent> <F6> :%s/\s\+$//<CR>''

" g<F6> to remove double spaces (often caused by J or gq)
nnoremap <silent> g<F6> :%s/\(\S\) \{2,}\(\S\)/\1 \2/g<CR>''

" <F7> to cycle spell
nnoremap <F7> :call CycleSpell()<CR>
inoremap <F7> <Esc>:call CycleSpell()<CR>a

" Press <F8> to toggle textwidth=80
nnoremap <F8> :call ToggleTextWidth()<CR>
inoremap <F8> <Esc>:call ToggleTextWidth()<CR>a

" <F9> to toggle paste
nnoremap <f9> :set paste!<cr>
inoremap <f9> <esc>:set paste!<cr>a

" Accumulative yank
nnoremap gy :call AccYank()<CR>
" Clear y register
nnoremap gcy :let @y=''<CR>

" Make line outcommented title
nnoremap <leader>t :call MakeCenterTitle('')<CR>

"}}}

""""""""""""""""""""""""""""""     Functions     """""""""""""""""""""""""""""""{{{

function! CycleSpell()
    let langs = ['', 'en', 'sv']

    let i = index(langs, &spl)
    let j = (i+1)%len(langs)
    let &spl = langs[j]

    if empty(&spl)
        set nospell
        echo "set nospell"
    else
        set spell
        echo "spelllang="&spl
    endif
endfun

function! ToggleTextWidth()
    if &textwidth
        echo "textwidth=0"
        set textwidth=0
        set wrap
    else
        echo "textwidth=80"
        set textwidth=80
        set nowrap
    endif
endfunction

" MakeCenterTitle
" Removes surrounding whitespace, and put text at the center of textwidth and
" then padd with comments (or optional other character) around it.
function! MakeCenterTitle(...)"{{{

    " Use commenstring character if no other string is specified
    let pad = (a:000 != [] && a:1 != '') ? a:1 : &commentstring[0]

    " Distance between text and padding:
    let safetyDistance = 5

    " Default width is 80 if textwidth=0
    let tw = (&textwidth > 0) ? &textwidth : 80

    " Trim surrounding whitespace
    s/^\s*//
    s/\s*$//

    " Get length of string
    execute "normal $"
    let contentSize = col(".")

    " Stuff happens
    let marginSize = (tw - contentSize)/2
    if (marginSize - safetyDistance > 0)
        let padding = marginSize - safetyDistance
    else
        let padding = 1
    endif
    let sr = marginSize - padding

    " insert leading padding chars
    " insert spacingRight spaces
    " insert trailing padding chars
    if (marginSize > 1)
        center
        exec "normal! 0".padding."r".pad."$".sr."a ".padding."a".pad."0"
    else
        echo "There was an error. Please fix."
    endif

endfunction"}}}

" Accumulative yank
function! AccYank()
    exec 'normal! yE'
    let @y=@y.@"
    let @"=@y
endfunction

"}}}

""""""""""""""""""""""""""""     Plugin helpers     """""""""""""""""""""""""""""{{{

" Commentary
map <leader>c :Commentary<CR>

" vim-easy-align
map ga <Plug>(EasyAlign)

" gitgutter
let g:gitgutter_enabled = 0

" slime
let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "0"}
let g:slime_dont_ask_default = 1

"}}}

"""""""""""""""""""""""""""""     To be moved     """"""""""""""""""""""""""""""{{{

" Docker
autocmd BufNewFile,BufRead Dockerfile*[^md] set syntax=dockerfile

" Git
autocmd Filetype gitcommit setlocal spell textwidth=72

" tex = latex
let g:tex_flavor = "latex"

"" Find a good place for:
au BufReadPost *.repy set syntax=python
autocmd FileType gnuplot setlocal commentstring=#\ %s
autocmd BufNewFile,BufRead *.log setfiletype log

" Prepopulate script files with shebang
autocmd BufNewFile  *.sh    0r ~/res/skeleton.sh
autocmd BufNewFile  *.py    0r ~/res/skeleton.py

"}}}

