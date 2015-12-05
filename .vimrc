set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I here by claim this space for my plugins accordingly
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These are the REALLY REALLY REALLY essential ones:
Plugin 'tpope/vim-sensible'             " Fix the stupid things left from Vi
Plugin 'tpope/vim-sleuth'               " Actually smart indentation
Plugin 'flazz/vim-colorschemes'         " It's stupid not to have colorschemes available.
Plugin 'tpope/vim-surround'             " Affect your surroundings. Example: ds'
Plugin 'bling/vim-airline'              " The status bar as it should be

" And here are some other neat plugins
Plugin 'LaTeX-Box-Team/LaTeX-Box'       " LaTeX tools
Plugin 'majutsushi/tagbar'              " Easy way to navigate log files
Plugin 'terryma/vim-multiple-cursors'   " Do it like they do it in sublime
Plugin 'godlygeek/tabular'              " Align on colon etc. Usage: 
Plugin 'kien/rainbow_parentheses.vim'   " Make shit pretty and readable
Plugin 'scrooloose/nerdcommenter'       " Semi automatic comments made easy 
Plugin 'loremipsum'                     " Lorem ipusm 
Plugin 'mattn/emmet-vim'                " The essential tool for web developers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Stuff:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" Usability fixes
" tex = latex
let g:tex_flavor = "latex"

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

let mapleader = ','
set ignorecase
set smartcase
set number
set splitbelow
set splitright
syntax on

" jklö
noremap l h
noremap ö l

"""" Cosmetics
"colorscheme molokai
"colorscheme tango
"colorscheme jelleybeans

"""" Tidy writing
"set autoindent
" autoindent uses the same indentation for the next row as the current row.
set smartindent
" smartindent uses a smarter alorithm than autoindent.
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=80
set linebreak 
set nowrap
set wrapmargin=0 " Prevent vim from automatically inserting line breaks in newly entered text.

"""" Mappings
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>

noremap <C-t> :tabedit<Space>
noremap <C-f> gg=G''
noremap <C-f><C-f> gggqG''

" Press <F5> to insert timestamp YYYY-MM-DD_HH:MM:SS
nnoremap <F5> "=strftime("%F_%T")<CR>P
nnoremap <F5><F5> "=strftime("%F")<CR>P
inoremap <F5> <C-R>=strftime("%F_%T")<CR>
inoremap <F5><F5> <C-R>=strftime("%F")<CR>

" f7 to toggle spell
nnoremap <f7> :set spell!<cr>
nnoremap <f7><f7> :set spl=sv<cr>
inoremap <f7> <esc>:set spell!<cr>a

" Press <F8> to toggle textwidth=80
nnoremap <F8> :call ToggleTextWidth()<CR>
inoremap <F8> <Esc>:call ToggleTextWidth()<CR>
function ToggleTextWidth()
    if &textwidth
        echo "textwidth=0"
        set textwidth=0
    else
        echo "textwidth=80"
        set textwidth=80
    endif
endfunction

highlight ColorColumn ctermbg=Black ctermfg=Red
let &colorcolumn=80             "Set what column to highlight.
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")

" Correct me
cnoremap so<space>& so<space>%
cnoremap Q q
cnoremap Wq wq
cnoremap WQ wq

" Quicklings
cnoremap qq q!
cab R .-1read 
cab spg spellgood

" To move between panes without pain
"nnoremap <c-j> <C-W><C-H>
"nnoremap <c-k> <C-W><C-J>
"nnoremap <c-l> <C-W><C-K>
"nnoremap <c-ö> <C-W><C-L>

"""" Macros
nnoremap <space><space> @q
nnoremap <leader><space> @

" Git
autocmd Filetype gitcommit setlocal spell textwidth=72

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


"""" Plugin helpers
" MultipleCursorsFind
nnoremap // :MultipleCursorsFind<Space>

" Lorem Ipsum
nnoremap <C-i><C-l> :Loremipsum 100<CR>

" RainbowParenthesis
nnoremap <Leader>rb :RainbowParenthesesToggle<CR>
"
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \]


" emmet
let g:user_emmet_leader_key='<C-l>' " Remember to use `,` after emmet leader 



"""" TODO """""
"autoclose
"toggle autoclose on/off

"if ((set wrap?) == ('wrap'))
"set number
    "vmap <silent> <Right> l
    "vmap <silent> <Left> h
    "vmap <silent> <Up> gk
    "vmap <silent> <Down> gj
    "nmap <silent> <Right> l
    "nmap <silent> <Left> h
    "nmap <silent> <Up> gk
    "nmap <silent> <Down> gj
    "imap <silent> <Up> <C-o>gk
    "imap <silent> <Down> <C-o>gj
"endif
