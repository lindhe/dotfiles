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
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-sleuth'
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
let g:tex_flavor = "latex"
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Usability fixes
let mapleader = ","

set number

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

"""" Cosmetics
"colorscheme monokai
"colorscheme jellybeans
colorscheme tango
syntax on
"set number
set ruler
set showcmd
set splitbelow
set splitright

"""" Tidy writing
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"""" Tidy reading
set linebreak 
set nowrap
set textwidth=0
set wrapmargin=0

"""" Maps
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <enter> i<enter>
noremap <C-t> :tabedit<Space>
noremap <C-f> ggVG=
noremap <C-w> :vsp<Space>

" Press f5 to insert timestamp YYYY-MM-DD_HH:MM:SS
nnoremap <F5> "=strftime("%F_%T")<CR>P
nnoremap <F5><F5> "=strftime("%F")<CR>P
inoremap <F5> <C-R>=strftime("%F_%T")<CR>
inoremap <F5><F5> <C-R>=strftime("%F")<CR>

cnoremap so<space>& so<space>%
cnoremap Q q
cnoremap qq q!
cnoremap R<Space> .-1read<space>

" To move between panes without pain
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""" Macros
nnoremap <S-Space> @q
nnoremap <Leader><Space> @q
let @q = ',c<space>j'

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

" auto-pairs å fix https://github.com/jiangmiao/auto-pairs/issues/88 and 93:
" let g:AutoPairsShortcutFastWrap=''

"""" TODO """""
" better esc
"
"autocmd FileType text setlocal textwidth=78
"
"autoclose
"toggle autoclose on/off

" Highlighting
"highlight ColorColumn ctermbg=Black ctermfg=Red
"let &colorcolumn=79             "Set what column to highlight.
"let &colorcolumn=join(range(81,999),",")
"let &colorcolumn="78,".join(range(120,999),",")


