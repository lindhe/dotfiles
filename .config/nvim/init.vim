""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""     NeoVim     """""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Andreas Lindhé
" Licence: MIT

"""""""""""""""""""""""""     vim-plug bootstrap     """"""""""""""""""""""{{{
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
"}}}

""""""""""""""""""""""""""""""     Plugins     """"""""""""""""""""""""""""{{{
let plugin_path = stdpath('data') . '/plugged'
call plug#begin(plugin_path)

" I cannot imagine Vim without these
Plug 'junegunn/vim-easy-align'        " Align on a character: `gaip&`
Plug 'mbbill/undotree'                " Here to save the day
Plug 'tpope/vim-commentary'           " Toggle comments
Plug 'tpope/vim-endwise'              " Autocomplete if ... endif
Plug 'tpope/vim-repeat'               " Make . repeat (some) plugin actions
Plug 'tpope/vim-sensible'             " Fix the stupid things left from Vi
Plug 'tpope/vim-speeddating'          " <c-a> and <c-x> correct with iso dates
Plug 'tpope/vim-surround'             " Affect your surroundings. Example: ds'

" Good ones, but dispensible
Plug 'apzelos/blamer.nvim'            " Git blame for Vim

call plug#end()
unlet plugin_path
"}}}

"""""""""""""""""""""""     Plugin Configurations     """""""""""""""""""""{{{

" Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_prefix = ' '
let g:blamer_date_format = '%Y-%m-%d'

"}}}

"""""""""""""""""""""""""""     File handling     """""""""""""""""""""""""{{{
set undofile
set list
set smarttab
set expandtab
set number

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

""""""""""""""""""""""""""""""     Mappings     """""""""""""""""""""""""""{{{
let mapleader = ','
noremap <space> :
cnoremap qq q!

" Clear hlsearch
nnoremap <silent> <c-l> :noh<CR>
inoremap <silent> <c-l> <esc>:noh<CR>a

" Macros
nnoremap <leader><leader> @q
nnoremap <enter> @@

" Tabs
nnoremap <C-t> :tabedit<Space>
nnoremap gf :tabedit <cfile><CR>

" Make line outcommented title
nnoremap <leader>t :call MakeCenterTitle('')<CR>

"}}}

"""""""""""""""""""""""""""""""     Movement     """"""""""""""""""""""""""""""""{{{

" hjkl --> jklö
noremap l h
noremap ö l
noremap s l

" Make vertical movement work with wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

"}}}

""""""""""""""""""""""     Filetype customizations     """"""""""""""""""""{{{
" *.vim files
autocmd BufNewFile,BufRead *.vim set foldmethod=marker
"}}}

""""""""""""""""""""""""     Function definitions     """""""""""""""""""""{{{

" MakeCenterTitle
" Removes surrounding whitespace, and put text at the center of textwidth and
" then padd with comments (or optional other character) around it.
function! MakeCenterTitle(...)
    "{{{

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

"}}}
endfunction

"}}}
