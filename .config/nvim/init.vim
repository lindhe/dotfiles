""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""     NeoVim     """""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Andreas Lindhé
" Licence: MIT


"""""""""""""""""""""""""""     File handling     """""""""""""""""""""""""{{{
set undofile
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

"}}}
